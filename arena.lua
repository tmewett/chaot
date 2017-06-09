local M = {}

function M.new()
	local a = {}
	for y = 1, 8 do
		a[y] = {}
		for x = 1, 8 do
			a[y][x] = 0
		end
	end
	return a
end

function M.draw(A, x0, y0)
	for y = 1, 8 do
		for x = 1, 8 do
			-- -1 and -2 to make grid lines
			gfx.rectangle('fill', x0+x*50 +1, y0+y*50 +1, 50-2, 50-2)
		end
	end
end

return M
