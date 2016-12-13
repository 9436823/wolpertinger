local graphics = require("graphics")


isomap = {}
local isomap_mt = {__index = isomap}

-- currently only supports one layer, one tile set tile maps
function isomap.new(filename)
	
	local testmap_lua = require(filename)
	local options = {
		width = testmap_lua.tilesets[1].tilewidth,
		height = testmap_lua.tilesets[1].tileheight,
		numFrames = testmap_lua.tilesets[1].tilecount 
	}
	local spritesheet = graphics.newImageSheet(testmap_lua.tilesets[1].image, options)

	local minions = {}

	
	local layergroups = {}
	local foglayers = {}
	
	-- aray that holds a mapping from tile id to tile edges
	local edges = {}
	for i,v in ipairs(testmap_lua.tilesets[1].tiles) do
		edges[v.id+1] = v.terrain
	end

	--todo passable terrain index is currently defined manually
	local origin = {x=0,y=0}
	local passable = 0
	
	-- grids
	local objectgrid = {}
	local accessgrid = {}
	local linkgrid = {}
	for i = 1,testmap_lua.height do
		accessgrid[i] = {}
		objectgrid[i] = {}
		linkgrid[i] = {}
	end
	
	local options = {
		width = 128,
		height = 112,
		numFrames = 1 
	}
	local fogSpriteSheet = graphics.newImageSheet("map_tiles/fog.png", options)
	foglayers[1] = display.newGroup()
	foglayers[2] = display.newGroup()
	
	-- draw the individual tiles
	for i, l in ipairs(testmap_lua.layers) do
		layergroups[i] = display.newGroup()
		for r = 1, l.height do
			for c = 1, l.width do
				local tile = display.newImage( spritesheet, l.data[(r-1)*l.width + (c-1) + 1])
				local fogTile = display.newImage(fogSpriteSheet, 1)
				accessgrid[r][c] = edges[l.data[(r-1)*l.width + (c-1) + 1]] or {-1,-1,-1,-1}
				objectgrid[r][c] = {}
				local t_w = testmap_lua.tilewidth/2
				local t_h = testmap_lua.tileheight/2
				local x_pos = c-1
				local y_pos = r-1
				tile:translate((x_pos* t_w)  - (y_pos * t_w), (y_pos* t_h)  + (x_pos * t_h))			
				layergroups[i]:insert(tile)
				fogTile:translate((x_pos* t_w)  - (y_pos * t_w), (y_pos* t_h)  + (x_pos * t_h))
				fogTile.isVisible = true
				foglayers[2]:insert(fogTile)	
			end
		end
	end
	foglayers[1]:toFront()
	foglayers[2]:toFront()

	-- create link grid based on accessgrid
	for r = 1,testmap_lua.height do
		for c = 1,testmap_lua.width do
			linkgrid[r][c] = {0,0,0,0}
			--nw
			if accessgrid[r][c-1] ~= nil and accessgrid[r][c-1][4] == passable and accessgrid[r][c][1] == passable then
				linkgrid[r][c][1] = 1
			end
			--ne
			if accessgrid[r-1] ~= nil and accessgrid[r-1][c][3] == passable and accessgrid[r][c][2] == passable then
				linkgrid[r][c][2] = 1
			end
			--sw
			if accessgrid[r+1] ~= nil and accessgrid[r+1][c][2] == passable and accessgrid[r][c][3] == passable then
				linkgrid[r][c][3] = 1
			end
			--se
			if accessgrid[r][c+1] ~= nil and accessgrid[r][c][1] == passable and accessgrid[r][c][4] == passable then
				linkgrid[r][c][4] = 1
			end
		end
	end
	
	
	local map = {}
	setmetatable(map,isomap_mt)
	
	
	
	map.testmap_lua = testmap_lua
	map.origin = origin
	map.id = "stub"
	map.layers = layergroups
	map.minions = minions
	map.foglayers = foglayers
	map.marklayer = display.newGroup()
	map.linkgrid = linkgrid
	map.accessgrid = accessgrid
	map.objectgrid = objectgrid
	map:addEventListener("touch", map)
	map.height = testmap_lua.height
	map.width = testmap_lua.width
	-- put on some marks
	--[[
	for r = 1,testmap_lua.height do
		for c = 1,testmap_lua.width do
			map:mark(r, c, 0, 0, {1, 0, 0})
		end
	end--]]
	return map
end

-- puts a circle at tile (r,c), optional with color {color}
function isomap:mark(r,c,y,x, color)
	local t_h = self.testmap_lua.tileheight/2
	local t_w = self.testmap_lua.tilewidth/2
	local xPos = ((c-1)* t_w)  - ((r-1) * t_w)
	local yPos = ((r-1) * t_h)  + ((c-1) * t_h)
	local circle = display.newCircle(self.origin.x+xPos, self.origin.y+yPos, 15)
	color = color or {1,1,1}
	circle:setFillColor(color[1],color[2],color[3])
	self.marklayer:insert(circle)
end

-- the touch handler also handles scrolling
function isomap:touch(event)
	if event.phase == "began" then

	elseif event.phase == "moved" then
		if (self.scrollX == nil) or (self.scrollY== nil) then
			self.scrollY = event.y
			self.scrollX = event.x
		end
		local dx = event.x - self.scrollX
		local dy = event.y - self.scrollY 
		self.scrollX = event.x
		self.scrollY = event.y
		self:translate(dx,dy)
	elseif event.phase == "ended" then
		self.scrollY=nil
		self.scrollX=nil
	end
end

function isomap:translate(x,y)
	for i,l in ipairs(self.layers) do
		l:translate(x,y)
	end
	for i,l in ipairs(self.foglayers) do
		l:translate(x,y)
	end
	for i, v in pairs(self.minions) do
		print(i)
		v.instance:translate(x,y)
	end
	self.marklayer:translate(x,y)
	self.origin.x = self.origin.x + x
	self.origin.y = self.origin.y + y
end

-- currently only adds eventlistener to layer 1
function isomap:addEventListener(name, func) 
	self.layers[1]:addEventListener(name, func)
end

-- currently puts the map tiles into a group
function isomap:insertIntoGroup(group)
	for i,l in ipairs(self.layers) do
		group:insert(l)
	end
	group:insert(self.marklayer)-- marklayer 
	for i,l in ipairs(self.foglayers) do
		group:insert(l)
	end
end

function isomap:centerCamera()
	print("Centered camera")
end

function isomap:addMinion(m, position)
	self.minions[m.name] = {instance=m, pos=position}
end

function isomap:mapToGlob(arg)
	arg.x = arg.x + self.origin.x
	arg.y = arg.y + self.origin.y
	return {x =   -32*arg.x+32*arg.y, y = 16*arg.x+16*arg.y}
end


-- Global basis is (1, 0), (0, 1)
-- Map basis is (-32, 16), (32, 16) wrt world basis
-- World basis is (-1/64 1/32), (1/64 1/32) wrt map basis
-- BW={-1/64	1/32} 
--	 {1/64 	1/32}
function isomap:globToMap(arg)
	arg.x = arg.x - self.origin.x 
	arg.y = arg.y - self.origin.y 
	return {x =  (-1/64)*arg.x+(1/32)*arg.y , y = (1/64)*arg.x+(1/32)*arg.y}
end

function isomap:mapToTile(arg)
	return {x=arg.x/32, y=arg.y/32}
end

function isomap:setFoW(r, c, bool)
		print(r, c, bool)
		self.foglayers[2][(r-1)*(self.testmap_lua.layers[1].width)+(c-1)+1].isVisible = bool
end
