
--[[---
  the slideFrame is a drop down console for visual content.
  @module slideFrame 
--]]
slideFrame = {}
local slideFrame_mt = {__index = slideFrame}
--- If position is top, console hides top, if position is bottom
-- console hides bottom.
-- @param position either "top" or "bottom" (default)
function slideFrame.new(position)
  local sf = setmetatable({}, slideFrame_mt)
  sf.contentGroup = display.newGroup()
  sf.position = position
  
  return sf
end

--todo add default handelers
function slideFrame:renderToGroup(group)
  self.isVisible = true
	local frame = display.newRect(0, 0, group.contentWidth , group.contentHeight)
	--frame:addEventListener("touch", emptyHandler)
	--frame:addEventListener("tap", emptyHandler)
	frame.anchorX = 0
	frame.anchorY= 0
	frame:setFillColor(1, 0, 0, 0.8)
	
	self.contentGroup = display.newGroup()
	self.contentGroup:insert(frame)
	
	self.dynamicContent = display.newGroup()
  local dummy = display.newRect(0, 0, group.contentWidth , group.contentHeight)
  dummy.isVisible = false
  self.dynamicContent:insert(dummy)
  
  
	self.contentGroup:insert(self.dynamicContent)
  
  group:insert(self.contentGroup)
  self:toggle()
end

function slideFrame:toggle()
  -- determine new position
  local yOff = self.contentGroup.contentHeight
  if self.position == "top" then
      yOff = -1.0 * yOff
  end
  if self.isVisible == false then
      yOff = -1.0 * yOff
  end
  local targetY = self.contentGroup.y + yOff

  --animate the transition
  local options = {
    x = 0,
    y = targetY,
    transition = easing.linear,
    time = 250,
    onComplete = function(event)  self.isVisible = not self.isVisible end,
    onStart = function(event)  print(targetY)  end
    }
  transition.moveTo(self.contentGroup, options)
end