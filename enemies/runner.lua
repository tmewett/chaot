local M = {}

function M.new()
	local en = enemy.new()
	mixin(en, M)

	en.vel = 300
	en.maxTurn = 0

	local arenax = arena.width
	local arenay = arena.height

	local xweight = (arenax / (arenax + arenay)) / 2
	local yweight = (arenay / (arenax + arenay)) / 2

	local spawnx, spawny = 0

	local rand = math.random()

	if rand < xweight then
		-- top spawn
		spawnx = math.random(0, arena.side * arenax)
		spawny = arena.side * -1
	elseif rand < xweight + yweight then
		-- right spawn
		spawnx = arena.side * (arenax + 1)
		spawny = math.random(0, arena.side * arenay)
	elseif rand < xweight + (2 * yweight) then
		-- left spawn
		spawnx = arena.side * -1
		spawny = math.random(0, arena.side * arenay)
	else
		-- bottom spawn
		spawnx = math.random(0, arena.side * arenax)
		spawny = arena.side * (arenay + 1)
	end

	en.x = spawnx
	en.y = spawny

	--[[ debug option
	en.spawnx = spawnx
	en.spawny = spawny]]

	return en
end

function M:update(dt)
	--This enemy runs straight at the player
	local dx = pl.x - self.x
	local dy = pl.y - self.y

	self.aim = math.atan2(dy, dx)

	enemy.update(self, dt)
end

return M
