--[[--- the sideFrame is a container for visual elements.
  it can be moved around freely by dragging 
  its button. However the button will never
  leave the visible area.
  @module sideFrame
--]]
require("restrictValueProxy")
--widget = require("widget")
sideFrame = {}
local sideFrame_mt = {__index = sideFrame}

--- default constructor
function sideFrame.new()
  local sf = setmetatable({}, sideFrame_mt)
  sf.contentGroup = display.newGroup()
  return sf
end

-- todo don't calculate the dimensions here on the fly
function sideFrame:renderToContainer(container)
  
  self.contentGroup = display.newGroup()
  
  local width = container.width
  local height = container.height
  --local width = display.actualContentWidth * 0.6
  --local height = display.actualContentHeight * 0.5
  
  -- frame
  local frame = display.newRect(0, 0, width, height)
  frame.anchorX = 0
  frame.anchorY = 0
  frame:setFillColor(0, 0, 1, 0.7)

  -- (drag) button
  local options = {
    x = width,
    y = 0,
    label = "P",
    shape = "circle",
    radius = 30,
    fillColor = { default={ 1, 0.2, 0.5, 0.7 }, over={ 1, 0.2, 0.5, 1 } }
    }
  local button = widget.newButton(options)
  
  -- drag behaviour
  local velocity = {}
  local previousPos = {}
  
  local function slideFunction(event)
    
    if event.phase == "began" then
      previousPos.x = event.x
      previousPos.y = event.y
      velocity.x = 0
      velocity.y = 0
    elseif event.phase == "moved" then
      local deltaX = event.x - previousPos.x
      local deltaY = event.y - previousPos.y
      
      -- smooth velocity
      velocity.x = 0.4 * velocity.x + 0.6 * deltaX 
      velocity.y = 0.4 * velocity.y + 0.6 * deltaY
      
      -- move frame to new pos
      self.contentGroup.x = event.x - width
      self.contentGroup.y = event.y
      
      previousPos.x = event.x
      previousPos.y = event.y
    elseif event.phase == "ended" then
      
      -- let it keep some of its momentum () after release
      if math.abs(velocity.x) + math.abs(velocity.y) > 0 then
        -- set the break acceleration in reverse direction and normalize
        local a = {}
        a.x = 4 * -velocity.x / (math.abs(velocity.x)+math.abs(velocity.y))
        a.y = 4 * -velocity.y / (math.abs(velocity.x)+math.abs(velocity.y))
        
        -- calculate time in frames till velocity == 0
        local t = 0
        if velocity.x > 0 then
           t = -velocity.x / a.x
        else
           t = -velocity.y / a.y
        end
        
        -- apply s(t) = 0.5 * a * t^2 + v * t
        local options = {
          x = event.x - width + (0.5 * a.x * t*t + velocity.x * t),
          y = event.y + (0.5 *a.y * t*t + velocity.y * t),
          time = t * 1000/30,--frames
          easing = easing.inOutQuad
        }
        
        -- restrict to visible area by using a proxy
        local proxy = restrictValueProxy.new(self.contentGroup, {
          x = {min = -width, max = display.actualContentWidth - width}, 
          y = {min = 0, max = display.actualContentHeight}
        })
        transition.moveTo(proxy, options)
        
      end
    end
    return true
    
  end
 
  button:addEventListener("touch", slideFunction)
  self.contentGroup:insert(frame)
  self.contentGroup:insert(button)
  
  self.contentContainer = container.new(width, height)
  self.contentContainer:insertIntoGroup(self.contentGroup)
  
  container.group:insert(self.contentGroup)
end

function sideFrame:getContainer()
  
    return self.contentContainer
end
