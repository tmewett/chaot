local M = {}

function M.new() 
	en = enemy.new()
	en.onFire = true
	en.vel = 200
	return en
end

function M:update(dt)
	--This enemy runs straight at the player
	local dx = pl.x - self.x
	local dy = pl.y - self.y

	self.aim = math.atan2(dy, dx)

	enemy.update(self, dt)

	--timer = time it stays in each state
	local timer = 4

	self.onFire = math.floor(math.mod((love.timer.getTime() - self.spawnTime)/timer, 2)) == 0

	if self.onFire == true then
		self.vel = 250
	else
		self.vel = 50
	end
end

return M
