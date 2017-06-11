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

	gfx.print("tile_x = " .. string.format("%.6f", pl.tile_x), 0, 0)
	gfx.print("tile_y = " .. string.format("%.6f", pl.tile_y), 0, 20)
	gfx.print("x = " .. pl.x, 0, 40)
	gfx.print("y = " .. pl.y, 0, 60)

	if pl.dead == true then
		gfx.setColor(255, 255, 255)
	else
		gfx.setColor(20, 200, 255)
	end
	
	gfx.circle('fill', midx, midy, 40)
end
