abstract type List end

# This is just laziness, but lists aren't a performance sensitive
# datastructure. That is to say: you shouldn't be using lists if you want
# performance.

struct VectorList <: List
    contents::Vector
end

function count(x::List)
    count(x.contents)
end

function first(x::List)
    first(x.contents)
end

function rest(x::List)
    rest(x.contents)
end

# REVIEW: Should I even define `conj` for lists? Lists will come full cloth for
# the most part. Let's see how far I get without it.

function list(xs...)
    VectorList(vector(xs...))
end

function tolist(xs)
    VectorList(vec(xs))
end

function vec(args::List)
    reduce(conj, emptyvector, args)
end

function string(x::List)
    "(" * transduce(interpose(" ") ∘ map(string), *, "", x) * ")"
end
