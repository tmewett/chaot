local M = {}
local allTypes = {"runner", "burner"}

for _, n in ipairs(allTypes) do
	M[n] = require('enemies/'..n)
end

function M.new()
	local ent = entity.new()
	mixin(ent, M)

	return ent
end

-- Append the instance to the list of actives.
M.active = {}
function M:spawn()
	M.active[#M.active+1] = self
end

function M:update(dt)

	entity.update(self, dt)

	--All enemies kill the player if they touch
	--TODO: cater for the size of the enemy
	if self.x >= pl.x - 40 and self.x <= pl.x + 40 and self.y >= pl.y - 40 and self.y <= pl.y + 40 and not pl.dead then
		pl.dead = true
	end

end

--[[ seq[<type>] is a mapping from seconds of game time to a table {n, p}
describing a binomial probability distribution. If a key is missing,
the previous defined value is used. For n=1 dists, a single number can be given. ]]
local seqLast = {}
local seq = {}
seq.runner = {
	[0]={3, 1}
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
