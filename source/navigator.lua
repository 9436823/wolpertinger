local heap = require("libs.heap.heap")
navigator = {}
local navigator_mt = {__index = navigator}

function navigator.new(name)
	local myNavigator = {}
	myNavigator = setmetatable(myNavigator, navigator_mt)
	return myNavigator
end

--navigating from start to destination tile, using a*
function navigator:navigate(map, sr, sc, dr, dc)
	print("navigator, got grid of size..."..#map.linkgrid.."x"..#map.linkgrid[1])
	local open = heap.valueheap{cmp = function(a, b)return a.f < b.f end}
		
	local start = {f=0, r=sr, c = sc, g=0}
	local dest = {f=0, r=dr, c=dc, g=0}

	--backpointers
	local foundPath = {}
	--set of currently open nodes
	local inHeap = {}
	--set of relaxed notes
	local closed = {}
	
	for r = 1,map.height do
		closed[r] = {}
		inHeap[r] = {}
		foundPath[r] = {}
		for c = 1,map.width do
			closed[r][c] = false
			inHeap[r][c] = false
			foundPath[r][c] = 0
		end
	end
	
	--expands node by examining its successors
	local function expand(cur)
		local successors = {{r=cur.r,c=cur.c-1, g=cur.g, f=cur.f},{r=cur.r-1,c=cur.c, g=cur.g, f=cur.f},{r=cur.r+1,c=cur.c, g=cur.g, f=cur.f},{r=cur.r,c=cur.c+1, g=cur.g, f=cur.f}}
		for i=1,4 do
			--impassable or already closed -> skip
			if  map.linkgrid[cur.r][cur.c][i] ~= 0 and closed[successors[i].r][successors[i].c] == false then 
				local tentative_g = map.linkgrid[cur.r][cur.c][i] + cur.g
				--examine if a) not already in heap or b) potentially better path available
				if  inHeap[successors[i].r][successors[i].c] == false or tentative_g < successors[i].g then
					foundPath[successors[i].r][successors[i].c] = i
					successors[i].g = tentative_g
					--successors[i].f = tentative_g + 1--here we take a super bad heuristic
					successors[i].f = tentative_g + math.sqrt((dest.r - successors[i].r)*(dest.r - successors[i].r) + (dest.c - successors[i].c)*(dest.c - successors[i].c))
					if inHeap[successors[i].r][successors[i].c] == true then
						--decrease key = find, remove, insert
						local index = 0
						while index < open:length() do
							index = index + 1
							local tmp = open.peek(index)
							if tmp.r == successors[i].r and tmp.c == successors[i].c then
								break
							end
							open:pop(index)
							open:push(successors[i])
						end
					else
						--open new succesor node
						open:push(successors[i])
						inHeap[successors[i].r][successors[i].c] = true
					end
				end
			end
		end
	end
	
	open:push(start)
	
	repeat
		local cur = open:pop()
		inHeap[cur.r][cur.c] = false
		if cur.r == dest.r and cur.c == dest.c then
			--debug print of best route
			print("path found")
		
			for r = 1,map.height do
				for c = 1,map.width do
					map:mark(r, c, 0, 0, {0.25*foundPath[r][c], 0, 0})
				end
			end
			
			map:mark(dest.r, dest.c, 0, 0, {1, 0, 0})
			map:mark(start.r, start.c, 0, 0, {0, 1, 0})
			local tmp = {r=dest.r, c=dest.c}
			while true do
				if foundPath[tmp.r][tmp.c] == 1 then
					tmp.c = tmp.c + 1
				elseif foundPath[tmp.r][tmp.c] == 2 then
					tmp.r = tmp.r + 1
				elseif foundPath[tmp.r][tmp.c] == 3 then
					tmp.r = tmp.r - 1
				elseif foundPath[tmp.r][tmp.c] == 4 then
					tmp.c = tmp.c - 1
				end
				map:mark(tmp.r, tmp.c, 0, 0, {0,0,1})
				if tmp.r == start.r and tmp.c == start.c then
					break
				end
				
			end
			return foundPath
		end
		closed[cur.r][cur.c] = true
		expand(cur)
	until open:length() == 0
	print("path not found")
	return nil
end

--todo exploring algorithms, like, explore area, explore direction
