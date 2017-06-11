local M = {}

function M.new() 
    ent = entity.new()
    
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

    --Arena boundaries 
	if self.x < 0 then
		self.x = 0
	elseif self.x > 160 * 8 then
		self.x = 160*8
	end

	if self.y < 0 then
		self.y = 0
	elseif self.y > 160 * 8 then
		self.y = 160 * 8
	end

    entity.update(self, dt)
end

return M