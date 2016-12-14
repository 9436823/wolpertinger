--tests
------------------------------------------------------------------------
--isomap.lua
------------------------------------------------------------------------
require ("isomap")
local eps = 0.001
local myMap = isomap.new("testmap")

--m(0, 1)=g(32, 16)
local t = myMap:mapToGlob({x=0,y=1})
assert(math.abs(t.x - 32) < eps and math.abs(t.y - 16) < eps)
--m(1, 0)=g(-32, 16)
t = myMap:mapToGlob({x=1,y=0})
assert(math.abs(t.x + 32) < eps and math.abs(t.y - 16) < eps)
--g(-32, 16)=m(1, 0)
t = myMap:globToMap({x=-32,y=16})
assert(math.abs(t.x -1) < eps and math.abs(t.y) < eps)
--g(32, 16)=m(0, 1)
t = myMap:globToMap({x=32,y=16})
assert(math.abs(t.x) < eps and math.abs(t.y - 1) < eps)
--g(64, 16)=m(-0.5, 1.5)
t = myMap:globToMap({x=64,y=16})
assert(math.abs(t.x + 0.5) < eps and math.abs(t.y - 1.5) < eps)
myMap = nil
------------------------------------------------------------------------
--hexmap
------------------------------------------------------------------------
require("hexmap")
local myHexmap = hexmap.new("hexagonal_huge")

local t = myHexmap:hexToMap(0, 1)
print(t.x, t.y)

local t = myHexmap:hexToMap(1, 2)
print(t.x, t.y)

t = myHexmap:hexToMap(1, 0)
print(t.x, t.y)
print("-------------------")

print("input: ", 0, 27)
t = myHexmap:mapToHex(-1, 27)
print(t.r, t.c)
--print(math.floor(t.r+0.5), math.floor(t.c+0.5))

t = myHexmap:mapToHex(0, 54)
print(t.r, t.c)
--print(math.floor(t.r+0.5), math.floor(t.c+0.5))


t = myHexmap:mapToHex(21, 27)
print(t.r, t.c)
--print(math.floor(t.r+0.5), math.floor(t.c+0.5))

t = myHexmap:mapToHex(42, 54)
print(t.r, t.c)--
--how shift this, so that 
--print(t.r+0.5, t.c+0.5)
--print(math.floor(t.r+0.5), math.floor(t.c+0.5))
--print(math.floor(t.r+0.5), math.floor(t.c+0.5) + math.floor(math.floor(t.r+0.5)/2))--row bleibt, col versetzen

t = myHexmap:mapToHex(63,81)
print(t.r, t.c)--
--how shift this, so that 
--print(t.r+0.5, t.c+0.5)
--print(math.floor(t.r+0.5), math.floor(t.c+0.5))
--print(math.floor(t.r+0.5), math.floor(t.c+0.5) + math.floor(math.floor(t.r+0.5)/2))--row bleibt, col versetzen

t = myHexmap:mapToHex(84,108)
print(t.r, t.c)--
--how shift this, so that 
--print(t.r+0.5, t.c+0.5)
--print(math.floor(t.r+0.5), math.floor(t.c+0.5))
--print(math.floor(t.r+0.5), math.floor(t.c+0.5) + math.floor(math.floor(t.r+0.5)/2))--row bleibt, col versetzen

t = myHexmap:mapToHex(42, 0)
print(t.r, t.c)
--print(math.floor(t.r+0.5), math.floor(t.c+0.5))
--now we have 0-indexed coordinates
------------------------------------------------------------------------
--
