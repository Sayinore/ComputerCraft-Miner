--array define area start
	local mineral = {
		"minecraft:coal_ore",
		"minecraft:iron_ore",
		"minecraft:redstone_ore",
		"minecraft:gold_ore",
		"minecraft:lapis_ore",
		"minecraft:quartz_ore",
	}

	local special = {
		"minecraft:diamond_ore",
		"minecraft:emerald_ore",
		"minecraft:mossy_cubbestone",
	}

	local smsg = {
		"Find diamond at ",
		"Find emerald at ",
		"Find monster spawner at ",
	}
--array define area end

--var define area start
	torch = 1
	cubbestone = 2

	--get distance area start
		print("How long do you want the miner to go? (unit:block(s))")
		times = read()
		hbtimes = times --have been go forward times
	--get distance area end

	--get xyz area start
		print("Please input x, y, z for the turtle.")
		print("x:")
		local x = read()
		print("y:")
		local y = read()
		print("z:")
		local z = read()
		
		print("Please input turtle facing.")
		print("East = 1")
		print("South = 2")
		print("West = 3")
		print("North = 4")
		local face = read()
	--get xyz area end
--var define area end



--function area start
	--[[notes of var "side" in function go(),compare(),dig():
			0:forward	1:left	2:back
			3:right  	4:up	5:down
			
			notes of var "side" in function dfs():
			0:around	1:up	2:down
	]]

	function go(side)
		if side == 0 then
			xyz(0)
			while not turtle.forward() do
				turtle.dig()
			end
		end
		
		if side == 1 then
			turtle.turnLeft()
			xyz(1)
			while not turtle.forward() do
				turtle.dig()
			end
			turtle.turnRight()
		end
		
		if side == 2 then
			xyz(2)
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
			xyz(3)
			while not turtle.forward() do
				turtle.dig()
			end
			turtle.turnLeft()
		end
		
		if side == 4 then
			xyz(4)
			while not turtle.up() do
				turtle.digUp()
			end
		end
		
		if side == 5 then
			xyz(5)
			while not turtle.down() do
				turtle.digDown()
			end
		end
	end

	function xyz(gside) --gside=go side
		if gside == 0 then
			if face == 1 then
				x = x + 1
			end
			
			if face == 2 then
				z = z + 1
			end
			
			if face == 3 then
				x = x - 1
			end
			
			if face == 4 then
				z = z - 1
			end
		end
		
		if gside == 1 then
			if face == 1 then
				z = z - 1
			end
			
			if face == 2 then
				x = x + 1
			end
			
			if face == 3 then
				z = z + 1
			end
			
			if face == 4 then
				x = x - 1
			end
		end
		
		if gside == 2 then
			if face == 1 then
				x = x - 1
			end
			
			if face == 2 then
				z = z - 1
			end
			
			if face == 3 then
				x = x + 1
			end
			
			if face == 4 then
				z = z + 1
			end
		end
		
		if gside == 3 then
			if face == 1 then
				z = z + 1
			end
			
			if face == 2 then
				x = x - 1
			end
			
			if face == 3 then
				z = z - 1
			end
			
			if face == 4 then
				x = x + 1
			end
		end
		
		if gside == 4 then
			y = y + 1
		end
		
		if gside == 5 then
			y = y - 1
		end
	end
	
	function compare(side)
		if side == 0 then
			success, data = turtle.inspect() --get block data
			
			if success then --compare block data
				for i = 1, table.getn(special) do
					if data.name == special[i] then
						asmsg = smsg[i].."x:"..x.." y:"..y.." z:"..z
						alert(asmsg)
						asmsg = "nil"
						return "special"
					end
				end
				
				for i = 1, table.getn(mineral) do
					if data.name == mineral[i] then
						asmsg = smsg[i].."x:"..x.." y:"..y.." z:"..z
						alert(asmsg)
						asmsg = "nil"
						return true
					end
				end
			else
				return false
			end
			
			return false
		end
		
		if side == 4 then		
			success, data = turtle.inspectUp() --get block data
			
			if success then --compare block data
				for i = 1, table.getn(special) do
					if data.name == special[i] then
						asmsg = smsg[i].."x:"..x.." y:"..y.." z:"..z
						alert(asmsg)
						asmsg = "nil"
						return "special"
					end
				end
				
				for i = 1, table.getn(mineral) do
					if data.name == mineral[i] then
						return true
					end
				end
			else
				return false
			end
			
			return false
		end
		
		if side == 5 then
			success, data = turtle.inspectDown() --get block data
			
			if success then --compare block data
				for i = 1, table.getn(special) do
					if data.name == special[i] then
						asmsg = smsg[i].."x:"..x.." y:"..y.." z:"..z
						alert(asmsg)
						asmsg = "nil"
						return "special"
					end
				end
				
				for i = 1, table.getn(mineral) do
					if data.name == mineral[i] then
						return true
					end
				end
			else
				return false
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
			if compare(0) == "special" then
					return "special"
			end
			
			for i = 1, 4 do
				if compare(0) then
					dig(0)
					go(0)
					
					dfs(0)
					dfs(1)
					dfs(2)
					
					go(2)
					place(0, cubbestone)
				end
				turtle.turnLeft()
			end
		end
		
		if side == 1 then
			if compare(4) == "special" then
				return "special"
			end
			
			if compare(4) then
				dig(4)
				go(4)
				
				dfs(0)
				dfs(1)
				dfs(2)
				
				go(5)
				place(4, cubbestone)
			end
		end
		
		if side == 2 then
			if compare(5) == "special" then
				return "special"
			end
			
			if compare(5) then
				dig(5)
				go(5)
				
				dfs(0)
				dfs(1)
				dfs(2)
				
				go(4)
				place(5, cubbestone)
			end
		end
	end

	function place(side, grid)
		if side == 0 then
			turtle.select(grid)
			turtle.place()
		end
		if side == 1 then
			turtle.turnLeft()
			turtle.select(grid)
			turtle.place()
			turtle.turnRight()
		end
		
		if side == 2 then
			turtle.turnLeft()
			turtle.turnLeft()
			turtle.select(grid)
			turtle.place()
			turtle.turnRight()
			turtle.turnRight()
		end
		
		if side == 3 then
			turtle.turnRight()
			turtle.select(grid)
			turtle.place()
			turtle.turnLeft()
		end
		
		if side == 4 then
			turtle.select(grid)
			turtle.placeUp()
		end
		
		if side == 5 then
			turtle.select(grid)
			turtle.placeDown()
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
		if dfs(0) == "special" then
			hbtimes = i
			break
		end
		
		if dfs(2) == "special" then
			hbtimes = i
			break
		end
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