local M = {}

function M.new()
	ent = entity.new()

	--player specific data can be appended to ent
	ent.tileX = 1
	ent.tileY = 1
	ent.inArena = true
	ent.dead = false
	ent.bound = true

	return ent
end

function M:update(dt)

	--Get the angle of the mouse relative to the player (screen centre)
	mdx = mouse.getX()-midx
	mdy = mouse.getY()-midy

	local aim = math.atan2(mdy, mdx)
	local len = vlength(mdx, mdy)

	self.vel = len
	self.aim = aim

	--Apply movement changes
	entity.update(self, dt)

	--Kill if on a red square
	if map[self.tileX][self.tileY] == 2 then
		self.dead = true
	end

end

return M
