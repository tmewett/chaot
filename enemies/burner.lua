local M = {}

function M.new()
	local en = enemy.new()
	mixin(en, M)

	en.x = math.random(arena.width*arena.side)
	en.y = math.random(arena.height*arena.side)
	en.radius = 25
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

	self.onFire = math.fmod(getTime() - self.spawnTime, timer*2) < timer

	if self.onFire then
		self.vel = 250
		self.vulnerable = false
	else
		self.vel = 50
		self.vulnerable = true
	end
end

function M:draw()
	if self.onFire then
		gfx.setColor(255, 165, 0)
	else
		gfx.setColor(139, 69, 19)
	end
	gfx.circle('fill', self.x, self.y, self.radius)
end

return M
