function vlength(x, y)
	return math.sqrt(x^2 + y^2)
end

function love.load()
	gfx = love.graphics
	mouse = love.mouse
	arena = require 'arena'
	entity = require 'entity'
	midx, midy = 400, 300

	pl = entity.new()
	pl.x = 640
	pl.y = 480
	map = arena.new()
	map[2][4] = 2
end

function love.update(dt)
	mdx = mouse.getX()-midx
	mdy = mouse.getY()-midy

	local aim = math.atan(mdy/mdx)

	if mdx < 0 and mdy <= 0 then
		aim = aim + math.pi
	elseif mdx > 0 and mdy < 0 then
		aim = aim + math.pi * 2
	elseif mdx < 0 and mdy > 0 then
		aim = aim + math.pi
	elseif mdx == 0 and mdy == 0 then
		aim = 0
	end

	len = vlength(mdx, mdy)
	
	pl.vel = len
	pl.aim = aim

	entity.update(pl, dt)

	if pl.x < 0 then
		pl.x = 0
	elseif pl.x > 160 * 8 then
		pl.x = 160*8
	end

	if pl.y < 0 then
		pl.y = 0
	elseif pl.y > 160 * 8 then
		pl.y = 160 * 8
	end

end

function love.draw()
	gfx.push()
	gfx.translate(midx-pl.x, midy-pl.y)
	arena.draw(map)
	gfx.pop()

	gfx.print("mdx = " .. mdx, 0, 0)
	gfx.print("mdy = " .. mdy, 0, 20)
	gfx.print("angle = " .. pl.aim, 0, 40)

	gfx.setColor(20, 200, 255)
	gfx.circle('fill', midx, midy, 40)
end
