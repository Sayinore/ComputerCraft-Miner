#ComputerCraft-Miner
Mine program with Depth-first search in ComputerCraft  


#Requirement
##Mod version
v1.64 or above

##Things in your map
- A GPS cluster ([How to build a GPS cluster?][1])
- (RECOMMEND) A wireless receiving computer

##Things in/on your mining turtle
- A wireless modem
- Fuels
- Filling blocks

#Useage
How to install:  
Open your turtle. Then use this command:  
`wget https://raw.githubusercontent.com/Sayinore/ComputerCraft-Miner/master/Miner.lua miner`


#Personalization
You may set your own settings. Just edit the following things:  
```lua
--REPLACE YOUR OWN SETTINGS HERE  
distance = [Your settings here]   
fillingblock = [Your settings here]  
--REPLACE YOUR OWN SETTINGS HERE
```  
They're all in the top of the program. Here's my recommend:  
```lua
--REPLACE YOUR OWN SETTINGS HERE  
distance = 32  
fillblock = "minecraft:cobblestone"  
--REPLACE YOUR OWN SETTINGS HERE  
```  

#Branches

|   Name of Branch   | Latest Version |              Merit               | Shortcoming               |       Remark        |
| :----------------: | :------------: | :------------------------------: | ------------------------- | :-----------------: |
| Master (RECOMMEND) |      v4.0      | Doesn't need to input xyz,facing | Needs a GPS culster       |   Will be updated   |
|      Self-GPS      |      v3.0      |   Doesn't need any GPS things    | Needs to input xyz,facing | Will NOT be updated |

#Changelog
##v4.0
2016-8-28
###Fixed
- Bug: The miner does NOT report the position of the mineral block, BUT the position of itself

###Changed
- Do NOT ask for distance, but you can set some settings by editing file

###Added
- Check in a message history before broading to the rednet. The same thing won't be reported twice

##v3.6
2016-6-9
###Addded
- Distinguish
  - Abandoned mine shaft
  - Nether fortresse
  - Fluid
- Replace fluid blocks with cobblestone

##v3.5 
2016-6-3
###Added
- Function isearch(),it can search any item in inventory of the turtle
- Release memory

###Fixed
- Bug: typo

##v3.0 2016-5-29
###Added
- GPS (Self-GPS and Outer-GPS)

##v2.6 
2016-5-28
###Added
- Put cobblestone of the diged ore
- Check special blocks

##v2.5 
2015-5-27
###Changed
- Optimize dfs(0)

###Added
- Array Mineral

###Removed
- Array Poop

##v2.0 
2016-5-26
###Changed
- Putting block in the turtle to compare block now need NOT!

##v1.1 
2016-5-23
###Fixed
- Can't search for ores behind the turtle
- Program can't stop by itself

###Added
- Tip before asking for distance

##v1.0 [NOT RECOMMEND]
2016-5-21
###Added
- Depth-first search

#License
Using Apache Lincense v2.0.  
See at [Open Source Initiative][2]

[1]:http://www.computercraft.info/forums2/index.php?/topic/3088-how-to-guide-gps-global-position-system "GPS Guide on Computercraft Forum"
[2]:https://opensource.org/licenses/Apache-2.0 "Apache License on Open Source Initiative"
