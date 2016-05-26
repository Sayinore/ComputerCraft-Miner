--var or array define area start
torch = 1

--get distance
print("How long do you want the miner to go? (unit:block(s))")
times = read()
hbtimes = times --have been go forward times
--end

local poop = {
	"minecraft:stone",
	"minecraft:gravel",
	"minecraft:dirt",
	"minecraft:cobblestone",
}
--var or array area end

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
		success, data = turtle.inspect() --get block data
		
		if success then --compare block data
			for i = 1, table.getn(poop) do
				if data.name == poop[i] then
					return true
				end
			end
		else
			return true
		end
		
		return false
	end
	
	if side == 1 then
		turtle.turnLeft()
		
		success, data = turtle.inspect() --get block data
		
		if success then --compare block data
			for i = 1, table.getn(poop) do
				if data.name == poop[i] then
					turtle.turnRight()
					return true
				end
			end
		else
			turtle.turnRight()
			return true
		end
		
		turtle.turnRight()
		return false
	end
	
	if side == 2 then
		turtle.turnLeft()
		turtle.turnLeft()
		
		success, data = turtle.inspect() --get block data
		
		if success then --compare block data
			for i = 1, table.getn(poop) do
				if data.name == poop[i] then
					turtle.turnRight()
					turtle.turnRight()
					return true
				end
			end
		else
			turtle.turnRight()
			turtle.turnRight()
			return true
		end
		
		turtle.turnRight()
		turtle.turnRight()
		return false
	end

	if side == 3 then
		turtle.turnRight()
		
		success, data = turtle.inspect() --get block data
		
		if success then --compare block data
			for i = 1, table.getn(poop) do
				if data.name == poop[i] then
					turtle.turnLeft()
					return true
				end
			end
		else
			turtle.turnLeft()
			return true
		end
		
		turtle.turnLeft()
		return false
	end
	
	if side == 4 then
		success, data = turtle.inspectUp() --get block data
		
		if success then --compare block data
			for i = 1, table.getn(poop) do
				if data.name == poop[i] then
					return true
				end
			end
		else
			return true
		end
		
		return false
	end
	
	if side == 5 then
		success, data = turtle.inspectDown() --get block data
		
		if success then --compare block data
			for i = 1, table.getn(poop) do
				if data.name == poop[i] then
					return true
				end
			end
		else
			return true
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
		dfs(2)
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
		dfs(1)
	
		if i%8 == 0 then
			turtle.select(torch)
			turtle.placeDown()
		end
	end

	turtle.turnLeft()
	turtle.turnLeft()
	go(5)
end
