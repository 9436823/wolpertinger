debugConsole = {}
local debugConsole_mt = {__index = debugConsole}

debugConsole.new = function()
	local dC = setmetatable({}, debugConsole_mt)
	
	dC.debugField = native.newTextField( 0, 0, 720, 50 )
    dC.debugField.anchorX = 0
    dC.debugField.anchorY = 0
    dC.debugField:translate(0, 1150)
    dC.debugField.size=24

    local function debugFieldHandler(event)
		if event.phase == "submitted" then
			print("text input submitted")
			dC.debugField.text = ""
		end
    end
    dC.debugField:addEventListener("userInput", debugFieldHandler)
	return dC
end
