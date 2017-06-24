local M = {}

function M.new()
	return {
		x=0,
		y=0,
		-- Targets
		vel=0,
		aim=0,
		-- Actual velocity and aim/heading
		_vel=0,
		_aim=0,
		
		spawnTime = love.timer.getTime(),

		-- Must stay in arena?
		bound=false
	}
end

function M:update(dt)
	local x = dt * self.vel * math.cos(self.aim)
	local y = dt * self.vel * math.sin(self.aim)
	self.x = x + self.x
	self.y = y + self.y

	if self.bound then
		--Arena boundaries, -1 so tileX&Y don't roll over at the +ve edges
		self.x = clamp(self.x, 0, 160*8-1)
		self.y = clamp(self.y, 0, 160*8-1)
	end

	--TODO: change to clamp
	--Work out tile coords we are above
	if self.bound or self.x >= 0 and self.x <= 160*8 and self.y >= 0 and self.y <= 160*8 then
		self.inArena = true

		self.tileX = math.floor(self.x / 160)+1
		self.tileY = math.floor(self.y / 160)+1
	else
		self.inArena = false

		--not sure this part is necessary
		self.tileX = -1
		self.tileY = -1
	end
end

return M
