function love.keypressed(key)
	if key == 'space' then
		if state == 'play' then
			state = 'pause'
		else
			state = 'play'
		end
	end
end

function draw_pause_screen()
	love.graphics.draw(pauseImage, 300, 200, 0)
	love.graphics.setColor(0, 0, 0, 150)
	love.graphics.rectangle('fill', 0, 0, 1024, 768)
end
