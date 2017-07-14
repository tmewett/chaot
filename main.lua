function vlength(x, y)
	return math.sqrt(x^2 + y^2)
end

function mixin(t, i)
	local mt = getmetatable(t) or {}
	index = mt.__index or {}
	for k,v in pairs(i) do
		index[k] = v
	end
	mt.__index = index
	setmetatable(t, mt)
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
	getTime = love.timer.getTime

	-- debug at http://localhost:8000/
	bird = require 'lovebird'

	-- seed to timestamp
	math.randomseed(os.time())
	gfx.setFont(gfx.newFont(32))

	midx, midy = 400, 300

	pl = player.new()
	pl.x = 640
	pl.y = 480
	map = arena.new()
	map[2][4] = 2

	testBurner = enemy.burner.new()
	testBurner.x = 2000
	testBurner.y = 2000
	testBurner:spawn()

	startTime = getTime()
	second = -1
end

function love.update(dt)
	bird.update()

	local sec = math.floor(getTime()-startTime)
	if sec > second and not pl.dead then
		second = sec
		enemy.spawnAll(second)
	end

	pl:update(dt)
	testBurner:update(dt)

	for _, en in ipairs(enemy.active) do
		en:update(dt)
		if en.deadly and pl:colliding(en) then
			pl.dead = true
		end
	end
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	elseif key == "space" then
		love.load()
	end
end

function love.draw()
	gfx.push()
	gfx.translate(midx-pl.x, midy-pl.y)
	arena.draw(map)

	for _, en in ipairs(enemy.active) do
		en:draw()
	end
	testBurner:draw()

	gfx.pop()

	pl:draw()
	gfx.print(second, 20, 20)
end
