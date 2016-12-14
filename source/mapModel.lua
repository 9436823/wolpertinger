--the map model should work with hex and isomaps transparently
require("tile")
mapModel = {}
local mapModel_mt = {__index = mapModel}

function mapModel.new(filename)
	local m = setmetatable({}, mapModel_mt)
	
	m.tiles = {}
	m.startTile = nil
	
	return m
end

-- this recursive iterator is not optimal. its prone to explode the stack
function mapModel:iterateTiles(func)
	local visited = {}
	
	local function visit(newTile, source)
		func(newTile, source)
		visited[newTile] = true
		
		for k, v in pairs(newTile.neighbours) do
			if (visited[v] ~= true) then
				visit(v, k)
			end
		end
	
	end
	visit(self.startTile, nil)
end


--the debug model is just an ordinary rectangular map with no movement
--restrictions
function mapModel:generateDebugModel()
	
	local function buildRow(length)
		local start = tile.new()
		local left = start
		for i = 1,length do
			local right = tile.new()
			right.type = ""..i
			left.neighbours["e"] = right
			right.neighbours["w"] = left
			left = right
		end
		return start
	end
	
	local function connectRowsVertical(r1, r2, even)
		local top = r1
		local bot = r2
		while true do
			-- connect
			if even then
				top.neighbours["sw"] = bot
				bot.neighbours["ne"] = top
				bot = bot.neighbours["e"]
				even = false
			else
				top.neighbours["se"] = bot
				bot.neighbours["nw"] = top
				top = top.neighbours["e"]
				even = true
			end
			if (top == nil) or (bot == nil) then
				break
			end
		end
	
	end

	rows = {}
	for i=1,24 do
		rows[i] = buildRow(20)
	end
	for i = 1,23 do
		connectRowsVertical(rows[i], rows[i+1], (i % 2) == 0)
	end
	
	self.startTile = rows[1]
	self:iterateTiles(function(tile, source) return end)

end
