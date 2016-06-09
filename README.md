#Computer-Craft
Lua programs in ComputerCraft  

#Branch

| Name of Branch | Merit | Shortcoming | Remark |
| :------------: | :-------------------------: | :-------------------: | :-------------: |
| Master         | Don't need input xyz,facing | Need GPS servers      | Will update     |
| SelfGPS        | Don't need GPS servers      | Need input xyz,facing | Will NOT update |

#Notice
Your ComputerCraft mod version must be over v1.64.  
Make sure that your turtle has fuels and a wireless modem.  
Make sure that there are 4 GPS servers at least. ([How to build a GPS cluster?][1])
Make sure that your turtle has cobblestones
#Useage
How to install:  
1. Open your turtle, creat file with a special name (e.g. jkfs)  
2. Search file name in explorer in you operating system  
3. Open the folder of the file
4. Put this program into the folder

#Changelog
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
- Wrong typing

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

###Deled
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

##v1.0 
2016-5-21
###Added
- Depth-first search

#License
Using Apache Lincense v2.0.  
See at [Open Source Initiative][2]

[1]:http://www.computercraft.info/forums2/index.php?/topic/3088-how-to-guide-gps-global-position-system "GPS Guide on Computercraft Forum"
[2]:https://opensource.org/licenses/Apache-2.0 "Apache License on Open Source Initiative"
