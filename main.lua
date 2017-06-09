
function love.load()
	gfx = love.graphics
	arena = require 'arena'

	map = arena.new()
end

function love.update(dt)

end

function love.draw()
	arena.draw(map, 0, 0)
end
