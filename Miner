print("Start!")

times = 64
hbtimes = times

function dig()
  turtle.select(15)
  if turtle.compare() then
    print("Diamond!!!")
    return true
  else
    turtle.dig()
  end
end

function digUp()
  turtle.select(15)
  if turtle.compare() then
    print("Diamond!!!")
    return true
  else
    turtle.digUp()
  end
end

function forward()
  while not turtle.forward() do
    turtle.dig()
  end
end

print("Go forward!")
for i = 1, times do
  if dig() then
    hbtimes = i - 1
    break
  end
  
  forward()
  
  if digUp() then
    hbtimes = i - 1
    break
  end
  
  if i%8 == 1 then
    turtle.select(16)
    turtle.placeUp()
  end
end

turtle.turnRight()
turtle.turnRight()

print("Go back!")
for i = 1, hbtimes do
  forward()
end

