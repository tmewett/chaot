local M = {}

function M.new()
	local ent = entity.new()
	mixin(ent, M)

	ent.radius = arena.side/4
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

function M:draw()
	if pl.dead then
		gfx.setColor(255, 128, 128)
	else
		gfx.setColor(20, 200, 255)
	end

	gfx.circle('fill', midx, midy, pl.radius)

end

return M
