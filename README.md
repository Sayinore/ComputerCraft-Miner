
# ComputerCraft-Miner
Mining program with Depth-first search in ComputerCraft

# Features
- Get all the minerals you can see in the mine road, and fill the air blocks with any block you want after digging mineral blocks
- Report the positions of special things (such as diamond ores, mob spawners, nether fortresses, abandoned mine shafts) to the host computer
- Place torches in the mine road
- Fill fluid blocks with any block you want
- Simple but useful functions (err, I mean functions like "`function()`")

# Requirement
## Mod version
v1.64 or above

## Things in your map
- **(RECOMMEND)** A GPS cluster ([How to build a GPS cluster?][1])  
  GPS clusters can help the miner to get its coordinates, so that **you do not need to input the coordinates or direction before going mining**. They are very **useful**.
- **(RECOMMEND)** A wireless receiving computer

## Things in/on your mining turtle
- A wireless modem
- Fuels
- Blocks to fill with
  The miner will fill the space with “Blocks to fill with” after digging the minerals.

# Usage
## Installation
Open your turtle.
If your mod version is 1.77 or above, then please use this command:
```shell
wget https://raw.githubusercontent.com/Sayinore/ComputerCraft-Miner/master/Miner.lua miner
```  
If it's not, please use the following command in lua mode:  
```lua
io.open("miner", "a");io.output("miner");io.write(http.get("https://raw.githubusercontent.com/Sayinore/ComputerCraft-Miner/master/Miner.lua miner").readAll());io.close()
```

## Usage
Place the mining turtle with this program, and then start this program by inputing “miner”  

# Personalization
You may set your own settings. Just edit the following things:
```lua
--REPLACE YOUR OWN SETTINGS HERE
distance = 32
fillingblock = "minecraft:cobblestone"
--REPLACE YOUR OWN SETTINGS HERE
```
They're all in the top of the program. And they're my recommend.


# Screenshots
![A Screenshot](http://i1.buimg.com/4851/26fdb7b141881bc3.png "A Screenshot")
![A Screenshot](http://i1.buimg.com/4851/9f82d50637a59c00.png "A Screenshot")
![A Screenshot](http://i1.buimg.com/4851/ca0c06d37d4dacf6.png "A Screenshot")
![A Screenshot](http://i1.buimg.com/4851/a50fb0f93db0dce5.png "A Screenshot")
![A Screenshot](http://i1.buimg.com/4851/0433db651e33d488.png "A Screenshot")
![A Screenshot](http://i1.buimg.com/4851/d72f28702dcc9072.png "A Screenshot")
![A Screenshot](http://i1.buimg.com/4851/638fd4655fe44ef8.png "A Screenshot")
![A Screenshot](http://i1.buimg.com/4851/dd7722807ffbc03f.png "A Screenshot")
![A Screenshot](http://i1.buimg.com/4851/eb3e5b3dc29d02c3.png "A Screenshot")

# Changelog
## v4.1
2016-12-16
### Added
- More Notes
- An item-check before go mining

### Changed
- Merged the two branches (master and Self-GPS), then whether there is a gps cluster, the program can work

## v4.0
2016-8-28
### Fixed
- Bug: The miner does NOT report the position of the mineral block, BUT the position of itself

### Changed
- Do NOT ask for distance, but you can set some settings by editing file

### Added
- Check in a message history before broadcasting to the red net. The same thing won't be reported twice

## v3.6
2016-6-9
### Added
- Distinguish
- Abandoned mine shaft
- Nether fortress
- Fluid
- Replace fluid blocks with cobblestone

## v3.5
2016-6-3
### Added
- Function isearch(), it can search any item in inventory of the turtle
- Release memory

### Fixed
- Bug: typo

## v3.0 2016-5-29
### Added
- GPS (Self-GPS and Outer-GPS)

## v2.6
2016-5-28
### Added
- Put cobblestone of the digged ore
- Check special blocks

## v2.5
2015-5-27
### Changed
- Optimize dfs(0)

### Added
- Array Mineral

### Removed
- Array Poop

## v2.0
2016-5-26
### Changed
- Putting block in the turtle to compare block now need NOT!

## v1.1
2016-5-23
### Fixed
- Can't search for ores behind the turtle
- Program can't stop by itself

### Added
- Tip before asking for distance

## v1.0 [NOT RECOMMEND]
2016-5-21
### Added
- Depth-first search

# License
Using Apache License v2.0.
See at [Open Source Initiative][2]

[1]:http://www.computercraft.info/forums2/index.php?/topic/3088-how-to-guide-gps-global-position-system "GPS Guide on ComputerCraft Forum"
[2]:https://opensource.org/licenses/Apache-2.0 "Apache License on Open Source Initiative"
