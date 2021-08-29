(ns clj-vulkan.api
  (:require [clojure.xml :as xml]
            [clojure.string :as str]
            [clojure.reflect :as r])
  (:import [java.nio.charset StandardCharsets]
           [org.lwjgl.system MemoryStack MemoryUtil]))

(defn invoke [x p]
  (clojure.lang.Reflector/invokeInstanceMethod x p (into-array [])))

(defn lwjgl-read-str [b]
  (-> b
      MemoryUtil/memUTF8Safe
      (str/replace  #"[^a-zA-Z_]" "")
      (str/trim)))

(def api-doc
  (xml/parse (java.io.File. "vk.xml")))

(defn vname
  "Returns the Vulkan API name of the class of an object"
  [x]
  (-> x
      class
      str
      (str/split #"\.")
      last))

(defn find-type [n]
  (->> api-doc
       xml-seq
       (filter #(= :type (:tag %)))
       (filter #(= n (:name (:attrs %))))
       first))

(defn parse [x]
  (->> x
       vname
       find-type
       xml-seq
       (filter #(= :member (:tag %)))
       (map :content)
       (map #(filter (comp (partial = :name) :tag) %))
       (map first)
       (map :content)
       (map first)
       (map (fn [p] [(keyword p) (invoke x p)]))
       (map (fn [[k v]] [k (if (= java.nio.DirectByteBuffer (type v))
                             (lwjgl-read-str v)
                             v)]))
       (into {})))
