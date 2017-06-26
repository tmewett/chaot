local M = {}

for _, n in ipairs({"runner", "burner"}) do
	M[n] = require('enemies/'..n)
end

function M.new()
	ent = entity.new()
	--enemy specific data can be appended to ent

	return ent
end

function M:update(dt)

	entity.update(self, dt)

	--All enemies kill the player if they touch
	--TODO: cater for the size of the enemy
	if self.x >= pl.x - 40 and self.x <= pl.x + 40 and self.y >= pl.y - 40 and self.y <= pl.y + 40 and not pl.dead then
		pl.dead = true
	end

end

return M
