--------------------------------------------------------------------
    -- Map - deselect listener should not trigger when map is out of focus
    --------------------------------------------------------------------
    local map = dusk.buildMap("desert.lua")

    map.setCameraFocus({x=400,y=200})
    
    local function deselectListener(event)
        if event.y > 1200 then
			return true
		end
        while #(gameState.selected) > 0 do 
            tmp = gameState.selected[#(gameState.selected)]
            gameState.selected[#(gameState.selected)] = nil
            tmp:deselect()
        end
        print("Deselect listener called on empty terrain")
        return true
    end

    map:addEventListener("tap", deselectListener)
    otherGroup:insert(map)
	--------------------------------------------------------------------
    --------------------------------------------------------------------
