function love.load()
	gfx = love.graphics

	floor = gfx.newImage("assets/floor.png")
end

function love.update(dt)

end

function love.draw()
	gfx.draw(floor, 0, 0)
end
