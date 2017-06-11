function love.load()
	gfx = love.graphics
	mouse = love.mouse
	arena = require 'arena'
	midx, midy = 400, 300

	pl = {x=640, y=480, heading=0}
	map = arena.new()
	map[2][4] = 2
end

function love.update(dt)
	mdx = math.min(mouse.getX()-320, .01)
	mdy = mouse.getY()-240
	pl.heading = math.asin(mdy/mdx)
end

function love.draw()
	gfx.push()
	gfx.translate(midx-pl.x, midy-pl.y)
	arena.draw(map)
	gfx.pop()

	gfx.setColor(20, 200, 255)
	gfx.circle('fill', midx, midy, 40)
end
