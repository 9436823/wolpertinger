require("oo")
displayItem = {}
local displayItem_mt = {__index = displayItem}

function displayItem.new(image)
	local dI = setmetatable({}, displayItem_mt)
	dI.imageName = image
	dI.image = nil

	return dI
end


function displayItem:tap(event)
	print("c_displayItem:tap()")
	return true
end

function displayItem:touch(event)
	--return true
	if event.phase == "ended" then
		print("picked up item")
		
		local function placeItem(iEvent)
			 if iEvent.phase == "began" then 
				print("PLACED")
				gs:place(self, iEvent.x, iEvent.y)
			 end
			 return true
		end
		gs:registerCallback("touch", placeItem)--or something like map:registercallback?
		
		--what now? need to register a global touch listener at the map to place the whole thing
	end
	return true
end

function displayItem:resize(width, height)
	print("c_displayItem:resize()")
end

function displayItem:renderToGroup(group)
	self.image = display.newImage(self.imageName )
	self.image.anchorX= 0
	self.image.anchorY = 0
	self.image:addEventListener("touch", self)
	self.image:addEventListener("tap", self)
	self.image:scale(0.5, 0.5)
	group:insert(self.image)
	print("rendering to group with width: ".. group.contentWidth)
end
