function vlength(x, y)
	return math.sqrt(x^2 + y^2)
end

function love.load()
	gfx = love.graphics
	mouse = love.mouse
	arena = require 'arena'
	entity = require 'entity'
	player = require 'player'
	midx, midy = 400, 300

	pl = player.new()
	pl.x = 640
	pl.y = 480
	map = arena.new()
	map[2][4] = 2
end

function love.update(dt)

	player.update(pl, dt)
	
end

function love.draw()
	gfx.push()
	gfx.translate(midx-pl.x, midy-pl.y)
	arena.draw(map)
	gfx.pop()

	gfx.print("mdx = " .. mdx, 0, 0)
	gfx.print("mdy = " .. mdy, 0, 20)
	gfx.print("angle = " .. pl.aim, 0, 40)

	gfx.setColor(20, 200, 255)
	gfx.circle('fill', midx, midy, 40)
end
