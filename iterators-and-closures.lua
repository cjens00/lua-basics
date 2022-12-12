-- Iterator. Uses a closure.
-- Counter Factory
function simpleCounter(max)
    local count = 0;
    -- when we return a function, 
    -- Lua is prompted to save the context
    -- thus producing a closure
    return function()
        count = count + 1;
        if count > max then
            return nil
        end
        return count;
    end
end

for v in simpleCounter(50) do
    print(v)
end
