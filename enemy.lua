local M = {}

function M.new() 
	ent = entity.new()
	
	--enemy specific data can be appended to ent

	return ent
end

function M:update(dt)
    entity.update(self, dt)

end

return M
