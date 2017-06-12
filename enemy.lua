local M = {}

function M.new() 
	ent = entity.new()
	ent.x = -500
	ent.y = -500
	--enemy specific data can be appended to ent

	return ent
end

function M:update(dt)
	local dx = pl.x - self.x
	local dy = pl.y - self.y

	self.vel = 150
	self.aim = math.atan2(dy, dx)

    entity.update(self, dt)

end

return M
