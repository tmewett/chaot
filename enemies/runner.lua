local M = {}

function M.new()
	local en = enemy.new()
	mixin(en, M)

	-- TODO: fetch from arena.lua once it's parameterised there
	local arenax = 8
	local arenay = 8

	local xweight = (arenax / (arenax + arenay)) / 2
	local yweight = (arenay / (arenax + arenay)) / 2

	-- Just for debug
	local spawnside = ""
	
	local rand = math.random()

	if rand < xweight then
		en.spawnside = "top"
		en.spawnx = math.random(0, arena.side * arenax)
		en.spawny = math.random(-100, -20)
	elseif rand < xweight + yweight then
		en.spawnside = "right"
		en.spawnx = math.random((arena.side * arenax) + 20, (arena.side * arenax) + 100)
		en.spawny = math.random(0, arena.side * arenay)
	elseif rand < xweight + (2 * yweight) then
		en.spawnside = "left"
		en.spawnx = math.random(-100, -20)
		en.spawny = math.random(0, arena.side * arenay)
	else
		en.spawnside = "bottom"
		en.spawnx = math.random(0, arena.side * arenax)
		en.spawny = math.random((arena.side * arenay) + 20, (arena.side * arenay) + 100)
	end

	en.x = en.spawnx
	en.y = en.spawny

	return en
end

function M:update(dt)
	--This enemy runs straight at the player
	local dx = pl.x - self.x
	local dy = pl.y - self.y

	self.vel = 150
	self.aim = math.atan2(dy, dx)

	enemy.update(self, dt)
end

return M
