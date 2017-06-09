
function love.load()
	gfx = love.graphics
	arena = require 'arena'

	map = arena.new()
end

function love.update(dt)

end

function love.draw()
	map[2][4] = 2
	arena.draw(map, 0, 0)
end
