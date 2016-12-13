require("graphics")

hexmap = {}
local hexmap_mt = {__index = hexmap}

function hexmap.new(file)
	local map = {}
	map = setmetatable(map, hexmap_mt)
	local testmap_lua = require(file)
	local spritesheets = {}
	local tilemapping = {}
	
	local offset = 0
	for i, v in ipairs(testmap_lua.tilesets) do
		
		local options = {
			width = v.tilewidth,
			height = v.tileheight,
			numFrames = v.tilecount 
		}
		spritesheets[i] = graphics.newImageSheet(v.image, options)
		
		-- build the id-> (tileset, tilenumber) mapping
		for n = 1, v.tilecount do
			tilemapping[offset + n] = {id=i, offset=offset}
		end
		offset = offset + v.tilecount
	end
	
	local layergroups = {}
	for i, v in ipairs(testmap_lua.layers) do
		-- ignore all non-tile layers
		if v.type == "tilelayer" then
			layergroups[i] = display.newGroup()
			for r = 1,v.height do
				for c = 1, v.width do
					local id = v.data[(r-1)*v.width + (c-1) + 1]
					if id ~= 0 then
						local tileset = tilemapping[id].id
						local offset = tilemapping[id].offset
						local tile = display.newImage(spritesheets[tileset], id - offset )
						-- why is there a (1,-1) offset? It seems the tiles are not centered at the spritesheet position
						tile:translate((c-1)*testmap_lua.tilewidth + (testmap_lua.tilewidth/2 * ((r+1)%2))+1, (r-1)* (testmap_lua.hexsidelength + (testmap_lua.tileheight-testmap_lua.hexsidelength)/2)-1 )--shift 1 -1
						layergroups[i]:insert(tile)
					end
				end
			end
			layergroups[i]:translate(v.offsetx, v.offsety)
		end
	end
	
	map.offset = {x=0, y=0}
	
	map.layergroups = layergroups
	map.markgroup = display.newGroup()
	map.miniongroup = display.newGroup()
	map.objectgroup = display.newGroup()
	
	map.tilewidth = testmap_lua.tilewidth
	map.tileheight = testmap_lua.tileheight
	map.hexsidelength = testmap_lua.hexsidelength
	
	map.minionTable = {}
	
	map:addEventListener("touch", map)	
	-- debug
	map:scale(7)
	print("map dimensions: ", map.tilewidth, map.tileheight, map.hexsidelength)
	
	map.snapFunction = function(x, y)
		return "offset is"..map.offset.x .." ".. map.offset.y
	end
	return map
end 

------------------------------------------------------------------------
--map interface
------------------------------------------------------------------------
function hexmap:hide(bool)
	bool = not bool
	for i, v in ipairs(self.layergroups) do
		v.isVisible = bool
	end
	self.markgroup.isVisible = bool
	self.miniongroup.isVisible = bool
	self.objectgroup.isVisible = bool
end

-- marks tile with colored circle
function hexmap:markTile(r, c, color)
	local color = color or {1, 0, 0}
	local center = self:mapToGlob(self:tileToMap({r=r, c=c}))
	local circle = display.newCircle(center.x, center.y, 4)
	circle:setFillColor(color[1], color[2], color[3], 1)
	self.markgroup:insert(circle)
end

-- translate the whole map with all visuals
function hexmap:translate(x, y)
	for i, v in ipairs(self.layergroups) do
		v:translate(x, y)
	end
	self.markgroup:translate(x, y)
	self.miniongroup:translate(x, y)
	self.objectgroup:translate(x, y)
	
	self.offset.x = self.offset.x + x
	self.offset.y = self.offset.y + y
end

-- scales map and all content
function hexmap:scale(s)
	for i, l in ipairs(self.layergroups) do
		l:scale(s, s)
	end
	--self.markgroup:scale(s, s)
	--self.miniongroup:scale(s, s)
	--todo scale visual positions
	self.tilewidth = self.tilewidth * s
	self.tileheight = self.tileheight * s
	self.hexsidelength = self.hexsidelength * s
end

-- map coordinates to screen coordinates
function hexmap:mapToGlob(arg)
	return  {x= arg.x + self.offset.x, y = arg.y + self.offset.y} 
end

-- screen coordinates to map coordinates
function hexmap:globToMap(arg)
	return  {x= arg.x - self.offset.x, y = arg.y - self.offset.y} 
end

-- 'hex' is coordinate system along x-axis and along right-lower side of tile
function hexmap:hexToMap(r, c)
	
	local x = 0.5 * self.tilewidth * r + self.tilewidth * c
	local y = r * 0.5 * (self.tileheight + self.hexsidelength) + 0 * c	
	return {x = x, y = y}
end


-- 'map' is coordinate system in pixels with origin at left upper map tile
function hexmap:mapToHex(x, y)
	--print("tilewidth ", self.tilewidth )
	local r = y / (0.5*(self.tileheight+self.hexsidelength))
	local c = -y / (self.tileheight+self.hexsidelength) +  x/self.tilewidth 
	--print("x is: " , x , " c is ", c)--x is faaar too big, why?
	-- shift offset of the coordinate system to align tile borders with 0 and 1
	-- floor to get integer index
	-- convert axial to offset coordinates
	-- +1 to get 1-indexed coordinates
	return {r = math.floor(r+0.5) + 1, c = math.floor(c+0.5) + math.floor(math.floor(r+0.5)/2) + 1}
end	

-- currently only adds eventlistener to layer 1
function hexmap:addEventListener(name, func)
	self.layergroups[1]:addEventListener(name, func)
end

-- touch listener of the map, currently used for scrolling
function hexmap:touch(event)
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

-- inserts the visual parts of the map into object group
function hexmap:insertIntoGroup(group)
	
	for i, l in ipairs(self.layergroups) do
		group:insert(l)
	end
	group:insert(self.markgroup)
	group:insert(self.miniongroup)
	group:insert(self.objectgroup)
end

-- adds a minion at x,y 'map' position. also adds to data structure
function hexmap:addMinion(minion, pos)
	
	--assumes minion pos is 0,0 global
	minion.outerGroup.x = 0
	minion.outerGroup.y = 0
	
	-- translate to position 
	local globPos = self:mapToGlob({x = pos.x, y = pos.y})
	minion:translate(globPos.x, globPos.y)
	local tile = self:mapToHex(pos.x, pos.y)
	
	-- add to minion group
	minion:insertIntoGroup(self.miniongroup)
	table.insert(self.minionTable, {minion=minion, pos=pos, currentTile=tile}) 
end

-- executes movement of all minions on the map. performs some checks + callbacks
function hexmap:moveMinions()
	for i, m in pairs(self.minionTable) do
		-- move minion
		-- get intended direction
		local delta = m.minion:getMoveIntent()
		
		m.pos.x = m.pos.x + delta.x 
		m.pos.y = m.pos.y + delta.y
		
		local currentTile = m.currentTile
		local newTile = self:mapToHex(m.pos.x, m.pos.y)
		
		--check if there is a transition
		if newTile.r ~= currentTile.r or newTile.c ~= currentTile.c then
			m.currentTile.r = newTile.r
			m.currentTile.c = newTile.c
			--print("new tile: ", newTile.r, newTile.c)
			m.minion:perceiveNewTile(newTile)
		end
		
		--	move sprite 
		m.minion:move(delta)
	end
end

function hexmap:addObject(object, x, y)
	print("coords: "..x.." "..y)
	local i = display.newImage(object.imageName, 100, 100 )
	local coords = self:globToMap({x=x, y=y})
	i:translate(coords.x, coords.y)
	self.objectgroup:insert(i)
end
