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
		_aim=0
	}
end

function M:update()

end

return M