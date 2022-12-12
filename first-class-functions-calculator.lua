function add(x,y)
    return x+y
end

function subtract(x,y)
    return x-y
end

function calculate(x,y,f)
    return f(x,y)
end

print "Enter a number"
local x = io.read("*n", "*l") -- As Number, consume newline

print "Enter another number"
local y = io.read("*n", "*l") -- As Number, consume newline

print "+ or - ?"
local op = io.read(1, "*l") -- Read one character, consume newline

if op == "+" then operation = add
else operation = subtract 
end

print(calculate(x,y,operation))
