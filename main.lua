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
	if sec > second then
		second = sec
		enemy.spawnAll(second)
	end

	pl:update(dt)

	for _, en in ipairs(enemy.active) do
		en:update(dt)
	end
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
	-- Need to have enemies draw themselves in a method
	gfx.setColor(0, 255, 20)
	for _, run in ipairs(enemy.active) do
		gfx.circle('fill', run.x, run.y, 20)
	end

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
