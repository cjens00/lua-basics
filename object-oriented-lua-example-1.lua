-- Approximation of classes and other OOP concepts in Lua
--[[
    ============================================================
    Metamethods:
    ============================================================
    __index         - if you called index, here is the behavior
    __newindex      - if it didnt exist already, do this
    Operator overloading:
        __add
        __sub
        __mul
        ...
    __call          - if it is called like a callable
    __tostring      - as type string, overrides default behavior
    ============================================================
]] --
-- Example 1, Superstrings: Concatenate with the '+' operator like normal languages
local meta = {}
local SS = {}

-- Same as ss["new"] = function(s) <...> end
-- Convention is to call it 'new' (constructor-type emulation)
function SS.new(s)
    -- Looks a lot like a constructor:
    local superString = {}
    superString.s = s
    setmetatable(superString, meta)
    return superString
end

function SS.add(s1, s2)
    return s1.s .. s2.s
end

-- Change the behavior of the '+' operator 
-- to what was defined in SS.add(s1, s2)
meta.__add = SS.add

-- If you index me, here's a list of what I'll do:
meta.__index = function(table, key)
    -- Define an attribute SS.reverse that returns 
    -- the result of this function
    if key == "reverse" then
        return string.reverse(table.s)
    end
end

firstName = SS.new("Matthias")
lastName = SS.new("Gates")

print(firstName + lastName)
print(firstName.reverse)
