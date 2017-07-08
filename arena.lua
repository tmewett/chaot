local M = {}
M.side = 160

local color = {
	[1]={50,50,50},
	[2]={255,50,50}
}

function M.new()
	local a = {}
	for x = 1, 8 do
		a[x] = {}
		for y = 1, 8 do
			a[x][y] = 1
		end
	end
	return a
end

function M:draw()
	for x = 1, 8 do
		for y = 1, 8 do
			gfx.setColor(color[self[x][y]])
			-- +1 and -2 to make grid lines
			gfx.rectangle('fill', (x-1)*M.side +1, (y-1)*M.side +1, M.side-2, M.side-2)
		end
	end
end

return M
