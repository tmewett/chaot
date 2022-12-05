function clamp(x, min, max)
	if x < min then
		x = min
	elseif x > max then
		x = max
	end
	return x
end

function sign(x)
	if x >= 0 then
		return 1
	else
		return -1
	end
end

function sign0(x)
	if math.abs(x) < 0.01 then
		return 0
	elseif x < 0 then
		return -1
	else
		return 1
	end
end

proto = {
	new = function (parent, child)
		child = child or {}
		child._super = parent
		parent.__index = parent
		setmetatable(child, parent)
		return child
	end
}
