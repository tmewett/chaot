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
	local t = {
		type=typ,
		spawnTime=getTime()
	}
	return t
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
	M.map = a
end

function M.draw()
	for x = 1, M.width do
		for y = 1, M.height do
			gfx.setColor(color[M.map[x][y].type])
			-- +1 and -2 to make grid lines
			gfx.rectangle('fill', (x-1)*M.side +1, (y-1)*M.side +1, M.side-2, M.side-2)
		end
	end
end

local seq = {
	[0]={3, 1},
	[5]={5, 1}
}

function M:spawnSeq(sec)

	local dist = seq[sec]
	-- no new seq? leave everything as-is
	if dist == nil then
		return
	end

	for i = 1, dist[1] do
		if math.random() < dist[2] then
			local tx = math.random(1, M.width)
			local ty = math.random(1, M.height)
			M.map[tx][ty] = tile.new('flame')
		end
	end
end

return M
