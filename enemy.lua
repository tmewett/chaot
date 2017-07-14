local M = {}
local allTypes = {"runner", "burner"}

for _, n in ipairs(allTypes) do
	M[n] = require('enemies/'..n)
end

function M.new()
	local ent = entity.new()
	mixin(ent, M)

	-- Kills on touch?
	ent.deadly = true

	return ent
end

-- Append the instance to the list of actives.
M.active = {}
function M:spawn()
	M.active[#M.active+1] = self
end

function M:despawn()
	for i, en in ipairs(enemy.active) do
		if en == self then
			table.remove(enemy.active, i)
			return
		end
	end
end

function M:update(dt)

	entity.update(self, dt)

	if self.tileX < -1 or self.tileX > arena.width+1 or self.tileY < -1 or self.tileY > arena.width+1 then
		self:despawn()
	end
end

--[[ seq[<type>] is a mapping from seconds of game time to a table {n, p}
describing a binomial probability distribution. If a key is missing,
the previous defined value is used. For n=1 dists, a single number can be given. ]]
local seqLast = {}
local seq = {}
seq.runner = {
	[0]={2, 3/4}
}
seq.burner = {
	[0]={1, 1},
	[1]={1, 1/5}
}

--[[ Spawns a number of the given enemy according to the probability
dist. in seq at time sec. ]]
local function spawnType(name, sec)

	local dist = (seq[name] or {})[sec] or seqLast[name] or {0, 0}
	if type(dist) == 'number' then
		dist = {1, dist}
	end
	seqLast[name] = dist

	for i = 1, dist[1] do
		if math.random() < dist[2] then
			M[name].new():spawn()
		end
	end
end

function M.spawnAll(t)
	for _, name in ipairs(allTypes) do
		spawnType(name, t)
	end
end

return M
