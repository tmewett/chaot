local M = {}

function M.new()
	ent = entity.new()

	--player specific data can be appended to ent
	ent.tileX = 1
	ent.tileY = 1
	ent.inArena = true
	ent.dead = false

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

	--Arena boundaries
	if self.x < 0 then
		self.x = 0
	elseif self.x >= 160 * 8 then
		self.x = (160 * 8) - 1
	end

	if self.y < 0 then
		self.y = 0
	elseif self.y >= 160 * 8 then
		self.y = (160 * 8) - 1
	end

	--Work out tile coords we are above
	if self.x >= 0 and self.x <= 160*8 and self.y >= 0 and self.y <= 160*8 then
		self.inArena = true

		self.tileX = math.floor((self.x / 160) + 1)
		self.tileY = math.floor((self.y / 160) + 1)
	else
		self.inArena = false

		--not sure this part is necessary
		self.tileX = -1
		self.tileY = -1
	end

	--Kill if on a red square
	if map[self.tileX][self.tileY] == 2 then
		self.dead = true
	end


end

return M
