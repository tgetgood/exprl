module DataStructures

import Base: string,hash,==,length,iterate, put!, bind

# How many bits of hash are used at each level of the HAMT?
hashbits = 5
nodelength = 2^hashbits
nil = nothing

include("./sexps.jl")
include("./sequential.jl")
include("./vector.jl")
include("./list.jl")
include("./map.jl")
include("./queue.jl")

# Sequential
export first, rest, take, drop, reduce, transduce, into, map, filter, interpose, dup, cat, partition

# Vectors
export  emptyvector, nth, vec, vector, zip

# Lists

export list, tolist

# Maps
export emptymap, assoc, update, dissoc, containsp, hashmap, merge, keys, vals

# Queues
export Queue, queue, emptyqueue, closedp, emptystream, put!, Stream, stream

# Generic
export conj, get, count, empty, emptyp, nil, keyword, name, symbol, withmeta, meta

# Types
export Keyword, Symbol, Map, Vector, MapEntry, List

end
