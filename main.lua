function love.load()
	gfx = love.graphics
	mouse = love.mouse
	arena = require 'arena'
	midx, midy = 400, 300

	pl = {x=640, y=480, a=0}
	map = arena.new()
	map[2][4] = 2
end

function love.update(dt)

end

function love.draw()
	gfx.push()
	gfx.translate(midx-pl.x, midy-pl.y)
	arena.draw(map, 0, 0)
	gfx.pop()

	gfx.setColor(20, 200, 255)
	gfx.circle('fill', midx, midy, 40)
end
