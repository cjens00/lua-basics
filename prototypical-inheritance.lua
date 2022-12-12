CalorieCounter = {
    calorieCount = 0,
    calorieGoal = 2000
}

-- Constructor
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

-- Add calories to the current calorieCount
function CalorieCounter:addCalories(amount)
    self.calorieCount = self.calorieCount + amount
end

-- Check to see if we reached our goal
function CalorieCounter:didReachGoal(amount)
    return self.calorieCount >= self.calorieGoal
end

-- Here we grab the CalorieCounter type and *add* to it (prototypical inheritance)
HealthMonitor = CalorieCounter:new {stepCount = 0, stepGoal = 10000}

-- Adding a brand new method
function HealthMonitor:addSteps(amount)
    self.stepCount = self.stepCount + amount
end

-- Redefining the existing 'method' CalorieCounter:didReachGoal()
function HealthMonitor:didReachGoal()
    local goalsReached = 0
    if self.calorieCount >= self.calorieGoal then
        print(string.format("Calorie goal of %d reached. (%d)", self.calorieGoal, self.calorieCount))
        goalsReached = goalsReached + 1
    else
        print(string.format("Calorie goal not yet reached. (%d/%d)", self.calorieCount, self.calorieGoal))
    end

    if self.stepCount >= self.stepGoal then
        print(string.format("Step goal of %d reached. (%d)", self.stepGoal, self.stepCount))
        goalsReached = goalsReached + 1
    else
        print(string.format("Step goal not yet reached. (%d/%d)", self.stepCount, self.stepGoal))
    end

    return goalsReached >= 2
end

-- New HealthMonitor type
healthMon = HealthMonitor:new {calorieGoal = 1500, stepGoal = 5000}

healthMon:addCalories(900)
healthMon:addSteps(4950)
print("Did you reach your goals? ", healthMon:didReachGoal())

print()

healthMon:addCalories(900)
healthMon:addSteps(1500)
print("Did you reach your goals? ", healthMon:didReachGoal())