local grades = {
    Adam = "100",
    Mary = "100",
    Teacher = "100"
};

while true do
    print("Enter student name (q to quit)");
    local name = io.read(); -- default read a line
    if name == "q" then
        break
    end
    print("Enter student score")
    local score = io.read("*n", "*l")
    grades[name] = score
end

-- Add onto some table:
grades.KenWatanabe = "9001"

-- if it has numeric keys, do this instead:
someTable = {
    100, 200, 300, 400
}
someTable[#someTable + 1] = 500

for k, v in pairs(someTable) do
    print "someTable:"
    -- print() is a variadic function in Lua, 
    -- meaning we can call it with however many args we want
    print(k, v)
end

print "Printing grades..."

-- pairs is a built-in iterator function, especially handy for k, v pairs
for k, v in pairs(grades) do
    print "Grade:"
    print(k, v)
end
