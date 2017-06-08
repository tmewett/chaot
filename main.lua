function love.load()
	gfx = love.graphics

	love.window.setMode(1920, 1080, {resizable=false, vsync=false})

	floor = gfx.newImage("assets/floor.png")
end

function love.update(dt)

end

function love.draw()
	gfx.draw(floor, 0, 0)
end
