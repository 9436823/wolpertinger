--[[---
  skinned container is a container with special background and
  border decoration, loaded from images
  @module
--]]
skinnedContainer = {}
local skinnedContainer_mt = {__index = skinnedContainer}

-- todo remove hard coded paths
-- todo implement getcontainer() (for content)
-- todo implement insertIntoGroup
function skinnedContainer.new()
  local sc = setmetatable({}, skinnedContainer_mt)
  sc.showBackground = true
  
  return sc
end

function skinnedContainer:renderToContainer(container)
  local width = container.width
  local height = container.height
  local group = container.group
  
  local path = "sprites/scaleframe_test/"
  local setSuffix = "scaleframe_test.png"
  
  self.top = display.newImage(path.."n_frame_"..setSuffix)
	self.bottom = display.newImage(path.."s_frame_"..setSuffix)
	self.left = display.newImage(path.."w_frame_"..setSuffix)
	self.right = display.newImage(path.."e_frame_"..setSuffix)

	self.nwCorner = display.newImage(path.."nw_corner_"..setSuffix)
	self.neCorner = display.newImage(path.."ne_corner_"..setSuffix)
	self.swCorner = display.newImage(path.."sw_corner_"..setSuffix)
	self.seCorner = display.newImage(path.."se_corner_"..setSuffix)
  
  if self.showBackground then
    self.background = display.newImage(path.."background_"..setSuffix)
    group:insert(self.background)
  end
  
  group:insert(self.top)
  group:insert(self.bottom)
  group:insert(self.left)
  group:insert(self.right)
  group:insert(self.nwCorner)
  group:insert(self.neCorner)
  group:insert(self.swCorner)
  group:insert(self.seCorner)
  
  self:resize(width, height)
end

function skinnedContainer:resize(width, height)
  if self.background then
    self.background.x = width * 0.5
    self.background.y = height * 0.5
    self.background.width = width
    self.background.height = height
  end
  
  self.top.width = width
  self.top.height = 20
  self.top.x = width * 0.5
  self.top.y = 0
  
  self.bottom.width = width
  self.bottom.height = 20
  self.bottom.x = width * 0.5
  self.bottom.y = height
  
  self.left.height = height
  self.left.width = 20
  self.left.x = 0
  self.left.y = height * 0.5
  
  self.right.height = height
  self.right.width = 20
  self.right.x = width
  self.right.y = height * 0.5
  
  self.nwCorner.width = 30
  self.nwCorner.height = 30
  self.nwCorner.x = 0
  self.nwCorner.y = 0
  
  self.neCorner.width = 30
  self.neCorner.height = 30
  self.neCorner.x = width
  self.neCorner.y = 0
  
  self.swCorner.width = 30
  self.swCorner.height = 30
  self.swCorner.x = 0
  self.swCorner.y = height
  
  self.seCorner.width = 30
  self.seCorner.height = 30
  self.seCorner.x = width
  self.seCorner.y = height
end

