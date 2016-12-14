--[[--- tabMenu is a container which allows to
  order visual content by categories.
  Categories can be accessed with the tab bar
--]]
require("displayItem")
require("oo")

tabMenu = inheritsFrom(displayItem)
local tabMenu_mt = {__index = tabMenu}

--- default constructor
function tabMenu.new()
	local tm = setmetatable({}, tabMenu_mt)
	return tm
end

function tabMenu:renderToGroup(group)
	local data = {}
	data.menuItems = {{id="a", img = "sprites/debug/a.png", content = {{id="a_1", callbacks="olo", img = "sprites/debug/b.png"}, {id="a_2", callbacks="olo2", img = "sprites/debug/c.png" }}},{id="b", img = "sprites/debug/b.png"},{id="c", img = "sprites/debug/c.png"},{id ="d", img = "sprites/debug/d.png"}}
	
	outerGroup = display.newGroup()
	local background = display.newRect(0, 0, group.contentWidth, group.contentHeight)
	background:setFillColor(0,0,1,1)
	background.anchorX = 0
	background.anchorY = 0
	outerGroup:insert(background)
	
	local nItems = #data.menuItems
	print("Menu containing items #: "..nItems)
	local itemWidth = group.contentWidth / nItems
	local itemHeight = 100
	
	
	contentGroup = display.newGroup()
	local n = 0
	for k, item in pairs(data.menuItems) do
		local tabRect = display.newRect( n * itemWidth, 0, itemWidth, itemHeight)
		tabRect:setFillColor(0, 1, 0 ,1)
		tabRect.anchorX = 0
		tabRect.anchorY = 0
		outerGroup:insert(tabRect)
		--load thumbnail for tabs
		
		local thumbnail = display.newImage(item.img,  n * itemWidth, 0)
		thumbnail.anchorX = 0
		thumbnail.anchorY = 0
		thumbnail:scale(0.25, 0.25)
		outerGroup:insert(thumbnail)
		local function selectItem()
			print("selected "..item.id.. " checking focus, visibility...")
			--something like remove all on group where item view resides
			
			
			--outerGroup:remove(contentGroup)
			contentGroup:removeSelf()
			contentGroup = display.newGroup()
			--contentGroup.anchorX = 0
			--contentGroup.anchorY= 0
			contentGroup:translate(0, 100)
			outerGroup:insert(contentGroup)
			if item.content == nil 
				then return
			else
				--render
				--for debug render this content in every tab with content
				local d1 = displayItem.new("sprites/debug/a.png")--needs a better constructor 
				d1:renderToGroup(contentGroup)
			end
			
		end
		thumbnail:addEventListener("tap", selectItem)
		n = n + 1
	end

	--outerGroup:insert(contentGroup)
	group:insert(outerGroup)
end
