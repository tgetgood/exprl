## FIXME: This isn't a very good tree walker. I'm not actually sure what
## prewalking would mean semantically as I think about it for the first
## time... if you transform before recursing, there's a hornet's nest of
## infinite loops waiting down there. Maybe that's just how it is and you have
## to be careful, I've never needed to perform structural changes while walking,
## save at the leaves.

""" leaves """
function walk(down, up, tree)
    up(tree)
end

# function walk(down, up, tree::LispList)
#     down(ArrayList(map(x -> walk(down, up, x), tree.elements)))
# end

function walk(down, up, tree::Vector)
    down(into(emptyvector, map(x -> walk(down, up, x)), tree.elements))
end

function walk(down, up, tree::Map)
    down(into(emptymap, map(x -> walk(down, up, x)), tree.kvs))
end

function walk(down, up, tree::MapEntry)
    down(MapEntry(up(tree.key), up(tree.value)))
end

function postwalk(f, tree)
    walk(f, f, tree)
end
