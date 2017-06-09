local M = {}

local color = {
	[1]={50,50,50},
	[2]={255,50,50}
}

function M.new()
	local a = {}
	for y = 1, 8 do
		a[y] = {}
		for x = 1, 8 do
			a[y][x] = 1
		end
	end
	return a
end

function M:draw(x0, y0)
	for y = 1, 8 do
		for x = 1, 8 do
			gfx.setColor(color[self[y][x]])
			-- -1 and -2 to make grid lines
			gfx.rectangle('fill', x0+(x-1)*160 +1, y0+(y-1)*160 +1, 160-2, 160-2)
		end
	end
end

return M
