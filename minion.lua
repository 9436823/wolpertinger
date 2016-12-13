minion = {}
local minion_mt = {__index = minion}

function minion.new(name)
	local m = {}
	m =  setmetatable(m, minion_mt)
	m.name = name or "unnamed"
        
	-- load main sprite
	local spriteFile = "animations/placeholder.png"
	local s = display.newImage(spriteFile)
	s:scale(0.25,0.25)
	s:translate(0, -20)
	m.observers = {}
	m.group = display.newGroup()
	m.group:insert(s)
        
	-- load shadow sprite
	--local spriteFileShadow = "animations/shadow.png"
	--local shadow = display.newImage(spriteFileShadow)--set opacity
	--shadow:scale(0.2,0.2)
	local shadow = display.newCircle(0,0, 4)--set opacity
	shadow:setFillColor(0,0,1,1)
	m.staticGroup = display.newGroup()
	m.staticGroup:insert(shadow)
	m.staticGroup.alpha = 0.7
        
	-- debug text / name text output
	local textfield = display.newText({text=m.name, fontSize=14})
	textfield:translate(0, -45)
	m.staticGroup:insert(textfield)
        
	-- members-------------------------------------------------------
	m.outerGroup = display.newGroup()
	m.outerGroup:insert(m.group)
	m.outerGroup:insert(m.staticGroup)
	-- memory variables----------------------------------------------
    -- wave movement  
    m.phase = 0
        
    -- character variables-------------------------------------------
    -- frequency of timeslots allocated for the minion to be concious
    m.thinkFrequency = 3000
        
    -- the periodic 'conciousnes' function
    timer.performWithDelay(3000, timer.performWithDelay(m.thinkFrequency, function(event) m:thinking(event) end))
	m.cPos = 0
	m.rPos = 0
	
	return m
end

-- translate displayed minion pos
function minion:translate(x, y)
	self.outerGroup:translate(x, y)
	--self.group:translate(x,y)
	--self.staticGroup:translate(x,y)
end

-- retrieves movement delta for next frame
function minion:getMoveIntent()
	return  {x = 0.21, y = 0.27}
	
end

-- performes movement by delta. handles visuals of movement
function minion:move(d)
	local speed = 1
		
	-- animate movement
	local amplitude = 0.3
	local frequency = 0.5
	local pOff = self.phase + (speed * frequency)
	self.phase = pOff
	self.group:translate(d.x*speed , d.y*speed + amplitude * math.cos(self.phase))
	self.staticGroup:translate(d.x*speed , d.y*speed )
end

-- consciousness of the minion, todo, refactor
function minion:thinking(event) 
	self:showDiscardMessage("I am thinking")
	self:notifyObservers()
	timer.performWithDelay(self.thinkFrequency, function(event) self:thinking(event) end)
end

-- shows a discard message, that automatically vanishes after some time
function minion:showDiscardMessage(text)
	local discardText = display.newText({text=text, fontSize=14})
	discardText:translate(0, 20)
	self.staticGroup:insert(discardText)
	local function removeDiscardText()
		self.staticGroup:remove(discardText)
	end
	timer.performWithDelay(self.thinkFrequency*0.7, removeDiscardText)
end
	
-- adds a tap listener to visual of minion
function minion:addTapListener(func)
	self.group:addEventListener("tap", func)
end
	
-- the tap callback function, with reference to ui
function minion:tapFunction(event, ui)--ui is source
	print("Minion tapped, ui ref is:", ui)
	
	self:addObserver("ui", ui:getObserverFunction())
	ui:displayObject(self)
	--use ui here to display self
end
	
-- inserts visuals of minion into object group
function minion:insertIntoGroup(group)
	group:insert(self.outerGroup)
end
	
-- callback on entering new tile, (stripped) reference to tile available here
function minion:perceiveNewTile(tile)
	self:showDiscardMessage("Entered tile: "..tile.r..", " .. tile.c)
	self.cPos = tile.c
	self.rPos = tile.r
end

function minion:getStats()
	return {Name = self.name, Int = 9, Cha = 12, RPos = self.rPos, CPos = self.cPos }
end
	
function minion:setStats()
	
end

function minion:addObserver(name, obs)
	--print("Observer attached: "..name)
	--print("minionname"..self.name)
	--for k, v in pairs(self) do
		--print(k, v)
	--end
	self.observers[name] = obs
end

function minion:removeObserver(name)
	self.observers[name] = nil
end

function minion:notifyObservers()
	--print("Notifying observers")
	for k, v in pairs(self.observers) do
		v(self:getStats())
	end
end


