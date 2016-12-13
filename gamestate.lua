
gamestate = {}
local gamestate_mt = {__index = gamestate}

function gamestate.new(session, map, ui)
	local gs = {}
	gs = setmetatable(gs, gamestate_mt)
	
	
	gs.session = session
	gs.running = false
	gs.minions = {}
	
	gs.navigator = navigator.new()-- todo, deprecated
	gs.map = map
	--ui.snapFunction = map.snapFunction--todo better do this before initialization
	gs.ui = ui
	
	gs.registeredCallback = {}
	return gs
end

------------------------------------------------------------------------
-- main loop
------------------------------------------------------------------------
function gamestate:mainloop(event)
	
	if not self.running then return end
	
	self.map:moveMinions()

	
end

-- setting up the game
function gamestate:start()
	-- debug, populate the map
	self:newMinion("bertha", {x=0,y=0})
	
	-- register the main loop function
	Runtime:addEventListener("enterFrame", function(event) self:mainloop(event) end)
end

-- add minion to gamestate and map
function gamestate:newMinion(name, pos)
	-- create minion
	local m = minion.new(name)
	
	-- add a tap listener with reference to ui
	local function tapFunction(event)
		m:tapFunction(event, self.ui)
	end
	m:addTapListener(tapFunction)
	
	-- minion resides in map
	self.map:addMinion(m, pos)
end


function gamestate:registerCallback(name, func)
	if self.registeredCallback[name] ~= nil then
		Runtime:removeEventListener(name, self.registeredCallback[name])
	end
	self.registeredCallback[name] = func
	Runtime:addEventListener(name, func)
end

function gamestate:place(object, x, y)
	self.map:addObject(object, x, y)
end
