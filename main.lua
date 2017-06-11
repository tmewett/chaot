function vlength(x, y)
	return math.sqrt(x^2 + y^2)
end

function love.load()
	gfx = love.graphics
	mouse = love.mouse
	arena = require 'arena'
	entity = require 'entity'
	midx, midy = 400, 300

	pl = entity.new()
	pl.x = 640
	pl.y = 480
	map = arena.new()
	map[2][4] = 2
end

function love.update(dt)
	mdx = math.max(mouse.getX()-320, .01)
	mdy = mouse.getY()-240

	len = vlength(mdx, mdy)
	pl.aim = math.asin(mdy/mdx)
	pl.vel = math.log(len+1)

	entity.update(pl, dt)
end

function love.draw()
	gfx.push()
	gfx.translate(midx-pl.x, midy-pl.y)
	arena.draw(map)
	gfx.pop()

	gfx.setColor(20, 200, 255)
	gfx.circle('fill', midx, midy, 40)
end
