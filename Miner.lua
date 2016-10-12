--var and array define area start
	--REPLACE YOUR OWN SETTINGS HERE
		distance = 32
		fillingblock = "minecraft:cobblestone"
	--REPLACE YOUR OWN SETTINGS HERE

	--IF YOUR MODS HAVE THEIR OWN THINGS, YOU CAN ADD THEM HERE
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
		"minecraft:mossy_cobblestone",
		"minecraft:planks",
		"minecraft:fence",
		"minecraft:nether_brick",
		"minecraft:stone_slab",
		"minecraft:double_stone_slab",
		"minecraft:nether_brick_fence",
		"minecraft:nether_brick_stairs",
		"minecraft:nether_wart",
	}

	local reportmsg = {
		"Found a diamond! See at ",
		"Found an emerald! See at ",
		"Found a monster spawner! See at ",
		"Found an abandoned mine shaft! See at ",
		"Found an abandoned mine shaft! See at ",
		"Found a nether fortress! See at ",
		"Found a nether fortress! See at ",
		"Found a nether fortress! See at ",
		"Found a nether fortress! See at ",
		"Found a nether fortress! See at ",
		"Found a nether fortress! See at ",
	}

	local fluid = {
		"minecraft:water",
		"minecraft:flowing_water",
		"minecraft:lava",
		"minecraft:flowing_lava",
	}

	local msghistory = {}
	--IF YOUR MODS HAVE THEIR OWN THINGS, YOU CAN ADD THEM HERE

--var and array area end

--function area start
	--[[notes of var "side" in function go(),compare(),dig():
		0:forward	1:left	2:back
		3:right  	4:up	5:down
		
		notes of var "side" in function dfs():
		0:around	1:up	2:down
	]]
	
	function go(side)
		if side == 0 then
			turtle.forward()
		end
		
		if side == 1 then
			turtle.turnLeft()
			turtle.forward()
			turtle.turnRight()
		end
		
		if side == 2 then
			turtle.back()
		end
		
		if side == 3 then
			turtle.turnRight()
			turtle.forward()
			turtle.turnLeft()
		end
		
		if side == 4 then
			turtle.up()
		end
		
		if side == 5 then
			turtle.down()
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

	function turnto(side)
		if (side == 1) then
			turtle.turnLeft()
		end

		if (side == 2) then
			turtle.turnLeft()
			turtle.turnLeft()
		end

		if (side == 3) then
			turtle.turnRight()
		end
	end

	function alert(message)
		rednet.open("right")
		rednet.broadcast(message)
	end

	function report(order, side)
		if (side == 0) then
			oldx, oldy, oldz = gps.locate()
			go(2)
			newx, newy, newz = gps.locate()
			go(0)

			if not (oldx == newx) then
				if (oldx < newx) then
					sx = oldx - 1
					sy = oldy
					sz = oldz
				end

				if (oldx > newx) then
					sx = oldx + 1
					sy = oldy
					sz = oldz
				end
			end

			if not (oldz == newz) then
				if (oldz < newz) then
					sz = oldz - 1
					sx = oldx
					sy = oldy
				end

				if (oldz > newz) then
					sz = oldz + 1
					sx = oldx
					sy = oldy
				end
			end
		end

		if (side == 4) then
			sx, y, sz = gps.locate()
			sy = y - 1
		end

		if (side == 5) then
			sx, y, sz = gps.locate()
			sy = y + 1
		end

		msg = reportmsg[order].."x:"..sx..", y:"..sy..", z:"..sz

		for i = 1, table.getn(msghistory) do
			if (msg == msghistory[i]) then
				return false
			end
		end

		table.insert(msghistory, msg)
		alert(msg)
	end

	function dfs(side)
		if side == 0 then			
			for i = 1, 4 do
				if (compare(0) == true) then
					dig(0)
					go(0)
					
					dfs(0)
					dfs(4)
					dfs(5)
					
					go(2)
					place(0, isearch(fillingblock))
				end
				turtle.turnLeft()
			end
		end
		
		if side == 4 then			
			if (compare(4) == true) then
				dig(4)
				go(4)
				
				dfs(0)
				dfs(4)
				dfs(5)
				
				go(5)
				place(4, isearch(fillingblock))
			end
		end
		
		if side == 5 then			
			if (compare(5) == true) then
				dig(5)
				go(5)
				
				dfs(0)
				dfs(4)
				dfs(5)
				
				go(4)
				place(5, isearch(fillingblock))
			end
		end
	end

	function compare(side)
		if side == 0 then
			success, data = turtle.inspect() --get block data
			
			if success then --compare block data
				for i = 1, table.getn(fluid) do
					if data.name == fluid[i] then
						place(0, isearch(fillingblock))
					end
				end

				for i = 1, table.getn(special) do
					if data.name == special[i] then
						report(i, 0)
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
		
		if side == 4 then		
			success, data = turtle.inspectUp() --get block data
			
			if success then --compare block data
				for i = 1, table.getn(fluid) do
					if data.name == fluid[i] then
						place(4, isearch(fillingblock))
					end
				end
			
				for i = 1, table.getn(special) do
					if data.name == special[i] then
						report(i, 4)
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
				for i = 1, table.getn(fluid) do
					if data.name == fluid[i] then
						place(5, isearch(fillingblock))
					end
				end
				
				for i = 1, table.getn(special) do
					if data.name == special[i] then
						report(i, 5)
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

	function isearch(iname) --item search, item name
		for i = 1, 16 do
			local data = turtle.getItemDetail(i)
			if data then
				if iname == data.name then
					return i
				end
			end
		end
		return false
	end
--function area end

for i = 1, 1 do
	alert("Starting mining...")

	for i = 1, distance do
		dig(0)
		go(0)
		dig(4)
		dfs(0)
		dfs(5)
	end

	alert("Start backing...")

	turtle.turnLeft()
	turtle.turnLeft()
	go(4)
	place(5, isearch("minecraft:torch"))


	for i = 1, distance do
		go(0)
		dfs(0)
		dfs(4)
	
		if i%8 == 0 then
			place(5, isearch("minecraft:torch"))
		end
	end

	turtle.turnLeft()
	turtle.turnLeft()
	go(5)
end
