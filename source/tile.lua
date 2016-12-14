tile = {}
local tile_mt = {__index = tile}

function tile.new(filename)
	local t = setmetatable({}, tile_mt)

	--Constructor / load from file
	t.type = 0
	t.neighbours = {}
	
	return t
end
