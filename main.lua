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

	testRunner = runner.new()
	testRunner.x = -500
	testRunner.y = -500

	testBurner = burner.new()
	testBurner.x = 2000
	testBurner.y = 2000

end

function love.update(dt)
	bird.update()
	player.update(pl, dt)
	runner.update(testRunner, dt)
	burner.update(testBurner, dt)
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

	--draw runner
	gfx.setColor(0, 255, 20)
	gfx.circle('fill', testRunner.x, testRunner.y, 20)

	--draw burner
	if testBurner.onFire then
		gfx.setColor(255, 165, 0)
	else
		gfx.setColor(139, 69, 19)
	end

	gfx.circle('fill', testBurner.x, testBurner.y, 25)

	gfx.pop()

	if pl.dead then
		gfx.setColor(255, 128, 128)
	else
		gfx.setColor(20, 200, 255)
	end

	gfx.circle('fill', midx, midy, 40)

end
