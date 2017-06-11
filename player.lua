local M = {}

function M.new() 
	ent = entity.new()
	
	--player specific data can be appended to ent
	ent.tile_x = 1
	ent.tile_y = 1
	ent.in_arena = true
	ent.dead = false

	return ent
end

function M:update(dt)
	--Get the angle of the mouse relative to the player (screen centre)
	mdx = mouse.getX()-midx
	mdy = mouse.getY()-midy

	local aim = math.atan(mdy/mdx)

	if mdx < 0 and mdy <= 0 then
		aim = aim + math.pi
	elseif mdx > 0 and mdy < 0 then
		aim = aim + math.pi * 2
	elseif mdx < 0 and mdy > 0 then
		aim = aim + math.pi
	elseif mdx == 0 and mdy == 0 then
		aim = 0
	end

	len = vlength(mdx, mdy)

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
		self.in_arena = true

		self.tile_x = math.floor((self.x / 160) + 1)
		self.tile_y = math.floor((self.y / 160) + 1)
	else
		self.in_arena = false

		--not sure this part is necessary
		self.tile_x = -1
		self.tile_y = -1
	end

	--Kill if on a red square
	if map[self.tile_x][self.tile_y] == 2 then
		self.dead = true
	end


end

return M
