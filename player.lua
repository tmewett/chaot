local M = {}

function M.new()
	ent = entity.new()

	ent.dead = false
	ent.bound = true

	return ent
end

function M:update(dt)

	--Get the angle of the mouse relative to the player (screen centre)
	mdx = mouse.getX()-midx
	mdy = mouse.getY()-midy

	local aim = math.atan2(mdy, mdx)
	local vel = vlength(mdx, mdy)
	vel = math.min(vel+100, 400)

	self.vel = vel
	self.aim = aim

	--Apply movement changes
	entity.update(self, dt)

	--Kill if on a red square
	if map[self.tileX][self.tileY] == 2 then
		self.dead = true
	end

end

return M
