-- Approximation of classes and other OOP concepts in Lua
--[[
    ========================================================================================================================
    Operations Controlled by Metatables (https://www.lua.org/manual/5.4/manual.html#2.4)
    ========================================================================================================================
    A detailed list of operations controlled by metatables. 
    Each event is identified by its corresponding key. By convention, all metatable keys 
    used by Lua are composed by two underscores followed by lowercase Latin letters.
    ========================================================================================================================
    __add:      the addition (+) operation. If any operand for an addition is not a number, 
                Lua will try to call a metamethod. It starts by checking the first operand (even if it is a number); 
                if that operand does not define a metamethod for __add, then Lua will check the second operand. 
                If Lua can find a metamethod, it calls the metamethod with the two operands as arguments, 
                and the result of the call (adjusted to one value) is the result of the operation. 
                Otherwise, if no metamethod is found, Lua raises an error.
    __sub:      the subtraction (-) operation. Behavior similar to the addition operation.
    __mul:      the multiplication (*) operation. Behavior similar to the addition operation.
    __div:      the division (/) operation. Behavior similar to the addition operation.
    __mod:      the modulo (%) operation. Behavior similar to the addition operation.
    __pow:      the exponentiation (^) operation. Behavior similar to the addition operation.
    __unm:      the negation (unary -) operation. Behavior similar to the addition operation.
    __idiv:     the floor division (//) operation. Behavior similar to the addition operation.
    __band:     the bitwise AND (&) operation. Behavior similar to the addition operation, 
                except that Lua will try a metamethod if any operand is neither an 
                integer nor a float coercible to an integer (see §3.4.3).
    __bor:      the bitwise OR (|) operation. Behavior similar to the bitwise AND operation.
    __bxor:     the bitwise exclusive OR (binary ~) operation. Behavior similar to the bitwise AND operation.
    __bnot:     the bitwise NOT (unary ~) operation. Behavior similar to the bitwise AND operation.
    __shl:      the bitwise left shift (<<) operation. Behavior similar to the bitwise AND operation.
    __shr:      the bitwise right shift (>>) operation. Behavior similar to the bitwise AND operation.
    __concat:   the concatenation (..) operation. Behavior similar to the addition operation, 
                except that Lua will try a metamethod if any operand is neither a 
                string nor a number (which is always coercible to a string).
    __len:      the length (#) operation. If the object is not a string, Lua will try its metamethod. 
                If there is a metamethod, Lua calls it with the object as argument, and the 
                result of the call (always adjusted to one value) is the result of the operation. 
                If there is no metamethod but the object is a table, then Lua uses the 
                table length operation (see §3.4.7). Otherwise, Lua raises an error.
    __eq:       the equal (==) operation. Behavior similar to the addition operation, 
                except that Lua will try a metamethod only when the values being compared are 
                either both tables or both full userdata and they are not primitively equal. 
                The result of the call is always converted to a boolean.
    __lt:       the less than (<) operation. Behavior similar to the addition operation, 
                except that Lua will try a metamethod only when the values being compared are 
                neither both numbers nor both strings. Moreover, the result of 
                the call is always converted to a boolean.
    __le:       the less equal (<=) operation. Behavior similar to the less than operation.
    __index:    The indexing access operation table[key]. 
                This event happens when table is not a table or when key is not present in table. 
                The metavalue is looked up in the metatable of table.
                The metavalue for this event can be either a function, a table, or any value with an __index metavalue. 
                If it is a function, it is called with table and key as arguments, 
                and the result of the call (adjusted to one value) is the result of the operation. 
                Otherwise, the final result is the result of indexing this metavalue with key. 
                This indexing is regular, not raw, and therefore can trigger another __index metavalue.
    __newindex: The indexing assignment table[key] = value. Like the index event, this event happens when table 
                is not a table or when key is not present in table. The metavalue is looked up in the metatable of table.
                Like with indexing, the metavalue for this event can be either 
                a function, a table, or any value with an __newindex metavalue. 
                If it is a function, it is called with table, key, and value as arguments. 
                Otherwise, Lua repeats the indexing assignment over this metavalue with the same key and value. 
                This assignment is regular, not raw, and therefore can trigger another __newindex metavalue.
                Whenever a __newindex metavalue is invoked, Lua does not perform the primitive assignment. 
                If needed, the metamethod itself can call rawset to do the assignment.
    __call:     The call operation func(args). This event happens when Lua 
                tries to call a non-function value (that is, func is not a function). 
                The metamethod is looked up in func. If present, the metamethod is called 
                with func as its first argument, followed by the arguments of the original call (args). 
                All results of the call are the results of the operation. 
                This is the only metamethod that allows multiple results.
    ========================================================================================================================
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
