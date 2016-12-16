--var and array define area start
	--REPLACE YOUR OWN SETTINGS HERE
		distance = 32
		fillingblock = "minecraft:cobblestone"
	--REPLACE YOUR OWN SETTINGS HERE

	--IF YOUR MODS HAVE THEIR OWN THINGS, YOU CAN ADD THEM HERE
		--[[
			add the item ids of the mineral blocks of your mods here
			you can see them in your inventory, and they're like this:
				"modname:blockname"
		]]
		 mineral = { --here are the blocks that the miner should dig
			"minecraft:coal_ore",
			"minecraft:iron_ore",
			"minecraft:redstone_ore",
			"minecraft:gold_ore",
			"minecraft:lapis_ore",
			"minecraft:quartz_ore",
		}

		--[[
			the things in the array "special", will be reported when the miner finds them
			and the message are in the array "reportmsg"
			so you should add something in "reportmsg" when you add something in "special"

			for example:
				1. the miner found the first block in "special""
				2. then it will choose the first message in "reportmsg", with the x, y and z coordinate of the block
		]]
		 special = { --here are the blocks that the miner should report
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

		 reportmsg = { --here are the messages that the miner should report
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

		 fluid = {
			"minecraft:water",
			"minecraft:flowing_water",
			"minecraft:lava",
			"minecraft:flowing_lava",
		}

		 msghistory = {} --this array saves the messages that already report
	--IF YOUR MODS HAVE THEIR OWN THINGS, YOU CAN ADD THEM HERE
--var and array area end

--setup area start
    if (gps.locate(1) == nil) then
        
			print("The turtle could not use gps.")
			print("Do you want the miner to report the coordinates of the special mineral? Answer \"Yes\" or \"No\".")
			local input = read()

			if (input == "Yes") or (input == "yes") then
				desire = true

				--get xyz area start
					print("Please input the coordinates for the turtle. (Press F3 and find \"Looking at\")")

					print("x:")
					x = read()
					print("y:")
					y = read()
					print("z:")
					z = read()

					--startxyz = vector.new(x, y, z)
					--x, y, z = nil

					print("Please input the direction which the turtle is facing.")
					print("South = 0")
					print("West = 1")
					print("North = 2")
					print("East = 3")

					direction = read()
				--get xyz area end
			end
			if (input == "No") or (input == "no") then
				desire = false
			end

        globalps = false
    else
        globalps = true
    end --"globalps" means gps
--setup area end

--function area start
	--[[
		what does the var "side" in function go(),compare(),dig() mean:
		0:forward	1:left	2:back
		3:right  	4:up	5:down
		
		what does the var "side" in function dfs() mean:
		0:around	4:up	5:down	(the same as others)
	]]--
	
	--basic function area start
		function xyz(gside) --gside=go side
			if (globalps == true) or (desire == false) then
				return
			end

			if (gside == 0) then
				if (direction == 0) then
					z = z + 1
				end

				if (direction == 1) then
					x = x - 1
				end
				
				if (direction == 2) then
					z = z - 1
				end
				
				if (direction == 3) then
					x = x + 1
				end
			end
			
			if (gside == 1) then
				if (direction == 0) then
					x = x + 1
				end
				
				if (direction == 1) then
					z = z + 1
				end
				
				if (direction == 2) then
					x = x - 1
				end

				if (direction == 3) then
					z = z - 1
				end
			end
			
			if (gside == 2) then			
				if (direction == 0) then
					z = z - 1
				end
				
				if (direction == 1) then
					x = x + 1
				end
				
				if (direction == 2) then
					z = z + 1
				end

				if (direction == 3) then
					x = x - 1
				end
			end
			
			if (gside == 3) then
				if (direction == 0) then
					x = x - 1
				end
				
				if (direction == 1) then
					z = z - 1
				end
				
				if (direction == 2) then
					x = x + 1
				end

				if (direction == 3) then
					z = z + 1
				end
			end
			
			if (gside == 4) then
				y = y + 1
			end
			
			if (gside == 5) then
				y = y - 1
			end
		end

		function go(side)
			if (side == 0) then
				xyz(0)
				turtle.forward()
			end
			
			if (side == 1) then
				xyz(1)
				turnto(1)
				turtle.forward()
				turnto(3)
			end
			
			if (side == 2) then
				xyz(2)
				turtle.back()
			end
			
			if (side == 3) then
				xyz(3)
				turnto(3)
				turtle.forward()
				turnto(1)
			end
			
			if (side == 4) then
				xyz(4)
				turtle.up()
			end
			
			if (side == 5) then
				xyz(5)
				turtle.down()
			end
		end

		function dig(side)
			if (side == 0) then
				turtle.dig()
			end
		
			if (side == 1) then
				turnto(1)
				turtle.dig()
				turnto(3)
			end
			
			if (side == 2) then
				turnto(2)
				turtle.dig()
				turnto(2)
			end
			
			if (side == 3) then
				turnto(3)
				turtle.dig()
				turnto(1)
			end
			
			if (side == 4) then
				turtle.digUp()
			end
			
			if (side == 5) then
				turtle.digDown()
			end
		end
		
		function place(side, grid)
			if (side == 0) then
				turtle.select(grid)
				turtle.place()
			end
			
			if (side == 1) then
				turnto(1)
				turtle.select(grid)
				turtle.place()
				turnto(3)
			end
			
			if (side == 2) then
				turnto(2)
				turtle.select(grid)
				turtle.place()
				turnto(2)
			end
			
			if (side == 3) then
				turnto(3)
				turtle.select(grid)
				turtle.place()
				turnto(1)
			end
			
			if (side == 4) then
				turtle.select(grid)
				turtle.placeUp()
			end
			
			if (side == 5) then
				turtle.select(grid)
				turtle.placeDown()
			end
		end

		function turnto(side)
			 if (side == 1) then
				if (globalps == false) and (desire == true) then
					direction = direction - 1
					if (direction < 0) then
						direction = direction + 4
					end
				end
				turtle.turnLeft()
			end

			if (side == 2) then
				if (globalps == false) and (desire == true) then
					direction = direction - 2
					if (direction < 0) then
						direction = direction + 4
					end
				end
				turtle.turnLeft()
				turtle.turnLeft()
			end

			if (side == 3) then
				if (globalps == false) and (desire == true) then
					direction = direction + 1
					if (direction > 4) then
						direction = direction - 4
					end
				end
				turtle.turnRight()
			end
		end

		function isearch(iname) --"isearch" means search an item, and "iname" means the name of the item
			for i = 1, 16 do
				 data = turtle.getItemDetail(i)
				if data then
					if iname == data.name then
						return i
					end
				end
			end
			return false
		end

		function alert(message)
		rednet.open("right")
		rednet.broadcast(message)
	end
	--basic function area end
	
	--advanced function area start
		function report(order, side)
			if (desire == false) then
				return
			end
			if (side == 0) then
				if (globalps == true) then
					oldx, oldy, oldz = globalps.locate()
					go(2)
					newx, newy, newz = globalps.locate()
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
				else
					 

					if (direction == 0) then
						sx = x
						sy = y
						sz = z + 1
					end

					if (direction == 1) then
						sx = x - 1
						sy = y
						sz = z
					end

					if (direction == 2) then
						sx = x
						sy = y
						sz = z - 1
					end

					if (direction == 3) then
						sx = x + 1
						sy = y
						sz = z
					end
				end
			end

			if (side == 4) then
				if (globalps == true) then
					sx, y, sz = globalps.locate()
				else
					sx = x
					sz = z
				end
				sy = y - 1
			end

			if (side == 5) then
				if (globalps == true) then
					sx, y, sz = globalps.locate()
				else
					sx = x
					sz = z
				end
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
			if (side == 0) then			
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
					turnto(1)
				end
			end
			
			if (side == 4) then			
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
			
			if (side == 5) then			
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
		if (side == 0) then
			local result, data = turtle.inspect() --get block data
			
			if (result == true) then --compare block data
				for i = 1, table.getn(fluid) do
					if (data.name == fluid[i]) then
						place(0, isearch(fillingblock))
					end
				end

				for i = 1, table.getn(special) do
					if (data.name == special[i]) then
						report(i, 0)
						return "special"
					end
				end
				
				for i = 1, table.getn(mineral) do
					if (data.name == mineral[i]) then
						return true
					end
				end
			end
			
			return false
		end
		
		if (side == 4) then
			local result, data = turtle.inspectUp() --get block data
			
			if (result == true) then --compare block data
				for i = 1, table.getn(fluid) do
					if (data.name == fluid[i]) then
						place(4, isearch(fillingblock))
					end
				end
			
				for i = 1, table.getn(special) do
					if (data.name == special[i]) then
						report(i, 4)
						return "special"
					end
				end
				
				for i = 1, table.getn(mineral) do
					if (data.name == mineral[i]) then
						return true
					end
				end
			end
			
			return false
		end
		
		if (side == 5) then
			local result, data = turtle.inspectDown() --get block data
			
			if (result == true) then --compare block data
				for i = 1, table.getn(fluid) do
					if (data.name == fluid[i]) then
						place(5, isearch(fillingblock))
					end
				end
				
				for i = 1, table.getn(special) do
					if (data.name == special[i]) then
						report(i, 5)
						return "special"
					end
				end
				
				for i = 1, table.getn(mineral) do
					if (data.name == mineral[i]) then
						return true
					end
				end
			end
			
			return false
		end
	end
	--advanced function are end	
--function area end

do --main function
	alert("Starting mining...")

	for i = 1, distance do
		dig(0)
		go(0)
		dfs(4)
		dfs(0)
		dfs(5)
	end

	alert("Start backing...")

	turnto(1)
	turnto(1)
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

	turnto(1)
	turnto(1)
	go(5)
end
