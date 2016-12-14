rasterImageScaleFrame = {}
local rasterImageScaleFrame_mt = {__index = rasterImageScaleFrame}

function rasterImageScaleFrame.new(path, setName)
	local rISF = setmetatable({}, rasterImageScaleFrame_mt)
	
	local setSuffix = setName
	
	
	rISF.nFrame = display.newImage(path.."n_frame_"..setSuffix)
	rISF.nFrame.anchorX = 0
	rISF.nFrame.anchorY = 0
	
	rISF.sFrame = display.newImage(path.."n_frame_"..setSuffix)
	rISF.sFrame.anchorX = 0
	rISF.sFrame.anchorY = 0
	
	rISF.wFrame = display.newImage(path.."w_frame_"..setSuffix)
	rISF.wFrame.anchorX = 0
	rISF.wFrame.anchorY = 0
	
	rISF.eFrame = display.newImage(path.."w_frame_"..setSuffix)
	rISF.eFrame.anchorX = 0
	rISF.eFrame.anchorY = 0
	
	rISF.nwCorner = display.newImage(path.."nw_corner_"..setSuffix)
	rISF.nwCorner.anchorX = 0
	rISF.nwCorner.anchorY = 0
	rISF.nwCorner.width = 50
	rISF.nwCorner.height = 50
	
	rISF.neCorner = display.newImage(path.."nw_corner_"..setSuffix)
	rISF.neCorner.anchorX = 0
	rISF.neCorner.anchorY = 0
	rISF.neCorner.width = 50
	rISF.neCorner.height = 50
	
	rISF.swCorner = display.newImage(path.."nw_corner_"..setSuffix)
	rISF.swCorner.anchorX = 0
	rISF.swCorner.anchorY = 0
	rISF.swCorner.width = 50
	rISF.swCorner.height = 50
	
	rISF.seCorner = display.newImage(path.."nw_corner_"..setSuffix)
	rISF.seCorner.anchorX = 0
	rISF.seCorner.anchorY = 0
	rISF.seCorner.width = 50
	rISF.seCorner.height = 50
	
	rISF.background = display.newImage(path.."background_"..setSuffix)
	rISF.background.anchorX = 0
	rISF.background.anchorY = 0
	
	
	return rISF
end


function rasterImageScaleFrame:fitToDims(dim)
	
	local width = dim.width
	local height = dim.height
	
	local hFrameLength = width - self.nwCorner.width - self.neCorner.width
	local vFrameLength = height - self.nwCorner.height - self.swCorner.height
	
	rISF.nFrame.width = hFrameLength
	rISF.sFrame.width = hFrameLength
	rISF.nFrame.height = 50
	rISF.sFrame.height = 50
	
	
	rISF.wFrame.height = vFrameLength
	rISF.eFrame.height = vFrameLength
	rISF.wFrame.width = 50
	rISF.eFrame.width = 50
	
	

end
