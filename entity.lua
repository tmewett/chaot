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

		daim=0,
		-- Linear accel and terminal angular vel, both per second
		accel=200,
		maxTurn=6,

		spawnTime = love.timer.getTime(),

		-- Must stay in arena?
		bound=false
	}
end

function M:update(dt)
	self.daim = self.aim - self._aim
	local dvel = self.vel - self._vel

	-- Due to the discontinuity in atan2, the signed daim is not always in the
	-- shortest direction. So check if we need to reverse it
	-- mag is |daim| in [0, 2pi)
	local mag = math.fmod(math.abs(self.daim), 2*math.pi)
	if mag > math.pi then
		-- reverse sign, complement angle
		self.daim = -self.daim/mag * (2*math.pi-mag)
	end

	local turn = self.maxTurn*dt
	turn = clamp(self.daim, -turn, turn)
	local accel
	if dvel >= 0 then
		accel = self.accel
	elseif dvel < 0 or mag > math.pi/2 then
		accel = -self.accel
	end
	self._vel = self._vel + accel*dt
	self._aim = self._aim + turn

	local x = dt * self._vel * math.cos(self._aim)
	local y = dt * self._vel * math.sin(self._aim)
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
