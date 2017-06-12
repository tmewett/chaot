function vlength(x, y)
	return math.sqrt(x^2 + y^2)
end

function clamp(x, min, max)
	if x < min then
		x = min
	elseif x > max then
		x = max
	end
	return x
end

function love.load()
	gfx = love.graphics
	mouse = love.mouse
	arena = require 'arena'
	entity = require 'entity'
	player = require 'player'
	enemy = require 'enemy'
	-- debug at http://localhost:8000/
	bird = require 'lovebird'

	midx, midy = 400, 300

	pl = player.new()
	pl.x = 640
	pl.y = 480
	map = arena.new()
	map[2][4] = 2

	runner = enemy.new()
end

function love.update(dt)
	bird.update()
	player.update(pl, dt)
	enemy.update(runner, dt)
end

function love.keypressed(key)
   if key == "escape" then
      love.event.quit()
   end
end

function love.draw()
	gfx.push()
	gfx.translate(midx-pl.x, midy-pl.y)
	arena.draw(map)

	--draw enemy
	gfx.setColor(0, 255, 20)
	gfx.circle('fill', runner.x, runner.y, 20)

	gfx.pop()

	if pl.dead then
		gfx.setColor(255, 255, 255)
	else
		gfx.setColor(20, 200, 255)
	end

	gfx.circle('fill', midx, midy, 40)

end
