local composer = require( "composer" )
local widget = require("widget")
widget.setTheme("widget_theme_android_holo_dark")

require("minion")
require("gamestate")
require("isomap")
require("ui")
require("navigator")
require("hexmap")
require("debugConsole")
require("mapModel")
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event ) 
	
	
	-- load ui, map and gamestate
    
    --myUi:hide(true)
    
    local myHexmap = hexmap.new("map_source.hexagonal_debug")
    local myUi = ui.new("scene 1 ui", myHexmap)
    
    myHexmap:insertIntoGroup(myUi.map)
    myHexmap:hide(false)

    
    local offX = 0
    local offY = 0
    local function drawFunc(tile, source)
		if source ~= nil then
			offY = offY  + 48
		end
		local tImg = display.newImage("b.png", offX, offY)
    
    end

    myMapModel = mapModel.new()
    myMapModel:generateDebugModel()
    --myMapModel:iterateTiles(drawFunc)
    
    
    gs = gamestate.new("scene 1", myHexmap, myUi)
    gs:start()
    
    -- input text console
    local dC = debugConsole.new()

    -- debug grid
    local linegroup = display.newGroup()
    for i=1,0 do
		local line = display.newLine(i*98, 0, i*98, 1280)
		line:setStrokeColor(1, 0, 0, 1)
		line.strikeWidth=10
		linegroup:insert(line)
	end
end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
		gs.running = true
        -- Code here runs when the scene is entirely on screen

    end
end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
		gs.running = false
        -- Code here runs immediately after the scene goes entirely off screen

    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
