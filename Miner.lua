--var define area start
times = read()
notore = 7 --number of non-mineral block
torch = 1
	--var calculate area start
	local selectNum = 16 - notore + 1 --first select lattice
	local compareTimes = notore
	hbtimes = times --have been go forward times
	--var calculate area end	
--var area end

--function area start
	--[[notes of var "side" in function go(),compare(),dig():
		0:forward	1:left	2:back
		3:right  	4:up	5:down
		
		notes of var "side" in function dfs():
		0:around	1:up	2:down

	]]
function go(side)
	if side == 0 then
		while not turtle.forward() do
			turtle.dig()
		end
	end
	
	if side == 1 then
		turtle.turnLeft()
		while not turtle.forward() do
			turtle.dig()
		end
		turtle.turnRight()
	end
	
	if side == 2 then
		while not turtle.back() do
			turtle.turnLeft()
			turtle.turnLeft()
			turtle.turnLeft()
			turtle.dig()
			turtle.turnRight()
			turtle.turnRight()
			turtle.turnRight()
		end
	end
	
	if side == 3 then
		turtle.turnRight()
		while not turtle.forward() do
			turtle.dig()
		end
		turtle.turnLeft()
	end
	
	if side == 4 then
		while not turtle.up() do
			turtle.digUp()
		end
	end
	
	if side == 5 then
		while not turtle.down() do
			turtle.digDown()
		end
	end
end

function compare(side)
	if side == 0 then
		if turtle.forward() then
			turtle.back()
			return true
		end
		
		for i = selectNum, 16 do
			turtle.select(i)
			if turtle.compare() then
				return true
			end
		end
		
		return false
	end
	
	if side == 1 then
		turtle.turnLeft()
		
		if turtle.forward() then
			turtle.back()
			turtle.turnRight()
			return true
		end
		
		for i = selectNum, 16 do
			turtle.select(i)
			if turtle.compare() then
				turtle.turnRight()
				return true
			end
				
		end
		
		turtle.turnRight()
		return false
	end
	
	if side == 2 then
		turtle.turnLeft()
		turtle.turnLeft()
		
		if turtle.forward() then
			turtle.back()
			turtle.turnRight()
			turtle.turnRight()
			return true
		end
		
		for i = selectNum, 16 do
			turtle.select(i)
			if turtle.compare() then
				turtle.turnRight()
				turtle.turnRight()
				return true
			end
		end
	end

	if side == 3 then
		turtle.turnRight()
		
		if turtle.forward() then
			turtle.back()
			turtle.turnLeft()
			return true
		end

		for i = selectNum, 16 do
			turtle.select(i)
			if turtle.compare() then
				turtle.turnLeft()
				return true
			end
		end
		
		turtle.turnLeft()
		return false
	end
	
	if side == 4 then
		if turtle.up() then
			turtle.down()
			return true
		end
		
		for i = selectNum, 16 do
			turtle.select(i)
			if turtle.compareUp() then
				return true
			end

		end
		
		return false
	end
	
	if side == 5 then
		if turtle.down() then
			turtle.up()
			return true
		end
		
		for i = selectNum, 16 do
			turtle.select(i)
			if turtle.compareDown() then
				return true
			end
		end
		
		return false
	end
end

function dig(side)
	if side == 0 then
		turtle.dig()
	end
	
	if side == 1 then
		turtle.turnLeft()
		turtle.dig()
		turtle.turnRight()
	end
	
	if side == 2 then
		turtle.turnLeft()
		turtle.turnLeft()
		turtle.dig()
		turtle.turnRight()
		turtle.turnRight()
	end
	
	if side == 3 then
		turtle.turnRight()
		turtle.dig()
		turtle.turnLeft()
	end
	
	if side == 4 then
		turtle.digUp()
	end
	
	if side == 5 then
		turtle.digDown()
	end
end

function dfs(side)
	if side == 0 then
		if compare(0) == false then
			dig(0)
			go(0)
			dfs(0)
			dfs(1)
			dfs(2)
			go(2)
		end
		
		if compare(1) == false then
			dig(1)
			go(1)
			dfs(0)
			dfs(1)
			dfs(2)
			go(3)
		end
		
		if compare(2) == false then
			dig(2)
			go(2)
			dfs(0)
			dfs(1)
			dfs(2)
			go(0)
		end
		
		if compare(3) == false then
			dig(3)
			go(3)
			dfs(0)
			dfs(1)
			dfs(2)
			go(1)
		end
	end
	
	if side == 1 then
		if compare(4) == false then
			dig(4)
			go(4)
			
			dfs(0)
			dfs(1)
			dfs(2)
			
			go(5)
		end
	end
	
	if side == 2 then
		if compare(5) == false then
			dig(5)
			go(5)
			
			dfs(0)
			dfs(1)
			dfs(2)
			
			go(4)
			
		end
	end
end

function alert(message)
	rednet.open("right")
	rednet.broadcast(message)
end
--function area end

for i = 1, 1 do
	alert("Starting mining...")

	for i = 1, times do
		dig(0)
		go(0)
		dig(4)
		dfs(0)
	end

	alert("Start backing...")

	turtle.select(torch)
	turtle.turnLeft()
	turtle.turnLeft()
	go(4)
	turtle.placeDown()


	for i = 1, hbtimes do
		go(0)
		dfs(0)
	
		if i%10 == 0 then
			turtle.select(torch)
			turtle.placeDown()
		end
	end

	turtle.turnLeft()
	turtle.turnLeft()
	go(5)
end
