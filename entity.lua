local M = {}

function M.new()
	local ent = {
		x=0,
		y=0,
		radius=arena.side/4,
		-- Targets
		vel=0,
		aim=0,
		-- Actual velocity and aim/heading
		_vel=nil,
		_aim=nil,
		-- Linear accel and terminal angular vel, both per second
		accel=200,
		maxTurn=6,

		spawnTime = love.timer.getTime(),

		-- Must stay in arena?
		bound=false
	}
	mixin(ent, M)
	return ent
end

function M:colliding(ent)
	local dx = ent.x - self.x
	local dy = ent.y - self.y
	if vlength(dx, dy) < self.radius + ent.radius then
		return true
	end
	return false
end

function M:touchingTile(tx, ty)
	-- top-left coords of tile
	local ax, ay = (tx-1)*arena.side, (ty-1)*arena.side

	--[[ Corners of the "expanded" tile, which is the hitbox for
	the centre of the entity. Clockwise from topleft: (x1, y1),
	(x2, y1), (x2, y2), (x1, y2) ]]
	local x1, x2 = ax-self.radius, ax+arena.side+self.radius
	local y1, y2 = ay-self.radius, ay+arena.side+self.radius

	if (self.x > x1 and self.x < x2) and (self.y > y1 and self.y < y2) then
		return true
	end
	return false
end

function M:update(dt)
	if not self._vel then
		self._vel = self.vel
	end
	if not self._aim then
		self._aim = self.aim
	end

	local daim = self.aim - self._aim
	local dvel = self.vel - self._vel

	-- Due to the discontinuity in atan2, the signed daim is not always in the
	-- shortest direction. So check if we need to reverse it
	-- mag is |daim| in [0, 2pi)
	local mag = math.fmod(math.abs(daim), 2*math.pi)
	if mag > math.pi then
		-- reverse sign, complement angle
		daim = -daim/mag * (2*math.pi-mag)
	end

	local turn = self.maxTurn*dt
	turn = clamp(daim, -turn, turn)
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

	local awidth, aheight = arena.width*arena.side, arena.height*arena.side

	if self.bound then
		--Arena boundaries, -1 so tileX&Y don't roll over at the +ve edges
		self.x = clamp(self.x, 0, awidth-1)
		self.y = clamp(self.y, 0, aheight-1)
	end

	self.tileX = math.floor(self.x / 160)+1
	self.tileY = math.floor(self.y / 160)+1

	-- could be rewritten to use tileX&Y
	if self.bound or self.x >= 0 and self.x <= awidth and self.y >= 0 and self.y <= aheight then
		self.inArena = true
	else
		self.inArena = false
	end
end

return M
