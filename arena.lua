local M = {}
M.side = 160
M.width = 8
M.height = 8

local color = {
	tile={50,50,50},
	flame={255,50,50}
}

local tile = {}
function tile.new(typ)
	return {
		type=typ,
		spawnTime=getTime()
	}
end

M.deadly = {
	tile = false,
	flame = true
}

function M.new()
	local a = {}
	for x = 1, M.width do
		a[x] = {}
		for y = 1, M.height do
			a[x][y] = tile.new('tile')
		end
	end
	-- for testing
	a[2][4] = tile.new('flame')
	return a
end

function M:draw()
	for x = 1, M.width do
		for y = 1, M.height do
			gfx.setColor(color[self[x][y].type])
			-- +1 and -2 to make grid lines
			gfx.rectangle('fill', (x-1)*M.side +1, (y-1)*M.side +1, M.side-2, M.side-2)
		end
	end
end

return M
