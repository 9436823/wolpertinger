widget = require("widget")
require("rasterImageScaleFrame")
require("tabMenu")
require("displayItem")

ui = {}
local ui_mt = {__index = ui}

function ui.new(name, map)
	local myUi = {}
	myUi = setmetatable(myUi, ui_mt)
	myUi.hexmap = map
	myUi.name = name
	-- stage layers
	myUi.background = display.newGroup()
	myUi.map = display.newGroup()
	myUi.ui = display.newGroup()
	myUi.front = display.newGroup()
	myUi.tabMenuGroup = display.newGroup()
	-- empty catch all handler
	local function emptyHandler(event)
		return true
	end
	--------------------------------------------------------------------
	-- assume 720x1280 and scale
	--------------------------------------------------------------------
	myUi.width = 720
	myUi.height = 1280
	--------------------------------------------------------------------
	-- top panel with button
	--------------------------------------------------------------------
	local meterGroup = display.newGroup()
	meterGroup.x = 0-(display.actualContentWidth-myUi.width)/2
	meterGroup.y = 0-(display.actualContentHeight-myUi.height)/2
	-- create bar
	local topRec = display.newRect(0, 0, display.actualContentWidth, 50)
	topRec:addEventListener("touch", emptyHandler)
	topRec:addEventListener("tap", emptyHandler)
    topRec.anchorX=0
    topRec.anchorY=0
	
	
	-- create button
	local function tbListener(event)
		myUi:toggleTopOverlay()
		return true
    end
    local options = {
		shape = "rect",
		fillColor = {default={ 1, 0.2, 0.5, 0.7 }, over={ 1, 0.2, 0.5, 1 } },
		label = "OPEN",
		left = myUi.width - 70,
		top = 0,
		anchorX = 0,
		anchorY = 0,
		height = 50+(display.actualContentHeight-myUi.height),
		width = 70+(display.actualContentWidth-myUi.width)/2,
		onPress = tbListener
    }
    local topButton = widget.newButton(options)
    
    meterGroup:insert(topRec)
    meterGroup:insert(topButton)
	myUi.ui:insert(meterGroup)
	--------------------------------------------------------------------
	--  top overlay menu
	--------------------------------------------------------------------
	myUi.topOverlayHidden = false
	local topOverlayRec = display.newRect(0,0,display.actualContentWidth, 0.4*myUi.height)
	topOverlayRec:addEventListener("touch", emptyHandler)
	topOverlayRec:addEventListener("tap", emptyHandler)
	topOverlayRec.anchorX = 0
	topOverlayRec.anchorY= 0
	topOverlayRec:setFillColor(1,0,0,0.8)
	
	myUi.topOverlayGroup = display.newGroup()
	myUi.topOverlayGroup.x = 0
	myUi.topOverlayGroup.y = 50
	myUi.topOverlayGroup:insert(topOverlayRec)
	
	myUi.topOverlayDynamicContent = display.newGroup()
	myUi.topOverlayGroup:insert(myUi.topOverlayDynamicContent)
	myUi.ui:insert(myUi.topOverlayGroup)
	myUi:toggleTopOverlay()

    --------------------------------------------------------------------
    -- bottom panel with button
    --------------------------------------------------------------------
    local bottomGroup = display.newGroup()
	bottomGroup.x = 0-(display.actualContentWidth-myUi.width)/2
	bottomGroup.y = myUi.height-80
	
	--create bar
	local bottomRec = display.newRect(0, 0, display.actualContentWidth, 80+(display.actualContentHeight-myUi.height))
    bottomRec:addEventListener("touch", emptyHandler)
	bottomRec:addEventListener("tap", emptyHandler)
    bottomRec.anchorX=0
    bottomRec.anchorY=0
    
    -- create button
    local function bbListener(event)
		myUi:toggleBottomOverlay()
		return true
    end
    local options = {
		shape = "rect",
		fillColor = {default={ 1, 0.2, 0.5, 0.7 }, over={ 1, 0.2, 0.5, 1 } },
		label = "OPEN",
		left = myUi.width - 70,
		top = 0,
		anchorX = 0,
		anchorY = 0,
		height = 80+(display.actualContentHeight-myUi.height),
		width = 70+(display.actualContentWidth-myUi.width)/2,
		onPress = bbListener
    }
    local bottomButton = widget.newButton(options)
	
	bottomGroup:insert(bottomRec)
	bottomGroup:insert(bottomButton)
	myUi.ui:insert(bottomGroup)
	--------------------------------------------------------------------
    -- Bottom Overlay menu
    --------------------------------------------------------------------
	myUi.bottomOverlayHidden = false
	local bottomOverlayRec = display.newRect(0,0,display.actualContentWidth, 0.4*myUi.height)
	bottomOverlayRec:addEventListener("touch", emptyHandler)
	bottomOverlayRec:addEventListener("tap", emptyHandler)
	bottomOverlayRec.anchorX = 0
	bottomOverlayRec.anchorY= 0
	bottomOverlayRec:setFillColor(1,0,0,0.8)
	
	myUi.bottomOverlayGroup = display.newGroup()
	myUi.bottomOverlayGroup.x = 0
	myUi.bottomOverlayGroup.y = myUi.height-(0.4*myUi.height+80)
	myUi.bottomOverlayGroup:insert(bottomOverlayRec)
	
	myUi.bottomOverlayDynamicContent = display.newGroup()
	myUi.bottomOverlayGroup:insert(myUi.bottomOverlayDynamicContent)
	myUi.ui:insert(myUi.bottomOverlayGroup)
	myUi:toggleBottomOverlay()
	 --------------------------------------------------------------------
    -- tabMenu in bottomOverlay
    --------------------------------------------------------------------
    local tm = tabMenu.new()
    tm:renderToGroup(myUi.bottomOverlayGroup)
	--------------------------------------------------------------------
    -- scene background
    --------------------------------------------------------------------
    local bg = display.newRect(0-(display.actualContentWidth-myUi.width)/2, 0-(display.actualContentHeight-myUi.height)/2,display.actualContentWidth, display.actualContentHeight)
    bg.anchorX=0
    bg.anchorY=0
    bg:setFillColor(.1,.1,.1,1)
    myUi.background:insert(bg)

	return myUi
end

function ui:toggleBottomOverlay()
	local sign = 1
	if self.bottomOverlayHidden == false then
		sign = -1
		self.bottomOverlayHidden = true
	else
		self.bottomOverlayHidden = false
	end
	self.bottomOverlayGroup:translate(sign*display.actualContentWidth, sign*display.actualContentHeight)
end


function ui:toggleTopOverlay()
	local sign = 1
	if self.topOverlayHidden == false then
		sign = -1
		self.topOverlayHidden = true
	else
		self.topOverlayHidden = false
	end
	self.topOverlayGroup:translate(sign*display.actualContentWidth, sign*display.actualContentHeight)
end


function ui:hide(bool)
	if bool == true then
		self.ui.isVisible = false
	else
		self.ui.isVisible = true
	end
end

function ui:displayObject(dispObject)
	-- check if object is displayable
	if dispObject.getStats == nil then
		return
	end
	
	-- get displayable data
	local valueList = dispObject:getStats() 
	
	-- show top overlay
	if self.topOverlayHidden == true then
		self:toggleTopOverlay()
	end
	
	-- clear view
	local n = self.topOverlayDynamicContent.numChildren
	for i=1,n do
		self.topOverlayDynamicContent:remove(1)
	end
	
	-- set dimensions of one entry
	local left = 10
	local top = 10
	local height = 20
	local width = 300
	local n = 0
	
	-- draw entries
	for i, v in pairs(valueList) do
		local t = display.newText({text = i.." : "..v, fontSize = 20})
		t.anchorX = 0
		t.anchorY = 0
		t.x = left
		t.y = top + (top + height) * n
		self.topOverlayDynamicContent:insert(t)
		n = n + 1
	end	
end

--observer update interface
function ui:getObserverFunction()
	local f = function(msg)
		print("UI-Observer got called")
		--update...
		local n = self.topOverlayDynamicContent.numChildren
		for i=1,n do
			self.topOverlayDynamicContent:remove(1)
		end
	
		-- set dimensions of one entry
		local left = 10
		local top = 10
		local height = 20
		local width = 300
		local n = 0
	
		-- draw entries
		for i, v in pairs(msg) do
			local t = display.newText({text = i.." : "..v, fontSize = 20})
			t.anchorX = 0
			t.anchorY = 0
			t.x = left
			t.y = top + (top + height) * n
			self.topOverlayDynamicContent:insert(t)
			n = n + 1
		end	
	end
	return f
end


