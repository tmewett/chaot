local M = {}

function M.new() 
	en = enemy.new()

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
