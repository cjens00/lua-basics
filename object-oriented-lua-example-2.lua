--[[ 
    Doing things the cleaner way.    
    The colon gives us the equivalent of e.g.,
    function CalorieCounter.add(self, amount) <...> end
    where self is equal to the CalorieCounter object (viva la Python!~).
]] --
CalorieCounter = {
    count = 0,
    goal = 2000
}

function CalorieCounter:add(amount)
    self.count = self.count + amount
end

function CalorieCounter:didReachGoal(amount)
    return self.count >= self.goal
end

function CalorieCounter:new(t)
    -- the 'or' operator means:
    -- IF we have t == nil.. then it will be an empty table
    -- So, it will be itself UNLESS it is nil, 
    -- in which case we specify the default value {} with 'or'
    t = t or {}
    setmetatable(t, self)
    self.__index = self
    return t
end

-- sekrit argyumint 'S.I.L.F.' (ew)
c = CalorieCounter:new{ goal = 1500 }
c:add(500)
print(c.count)
c:add(1500)
print(c.count)
print(c:didReachGoal())

