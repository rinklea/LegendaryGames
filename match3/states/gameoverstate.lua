gameoverstate=class{_includes=basestate}

function gameoverstate:init()
	score=0
	level=1
	goal=500
end

function gameoverstate:update(dt)
	if love.keyboard.waspressed('return') then
		gSounds['select']:play()
		gStatemachine:change('start')
	end
end

function gameoverstate:render()
	love.graphics.setColor(1,1,1,1)
	love.graphics.draw(background,-backgroundx,0)
	for y=1,8 do
		for x=1,8 do	
			love.graphics.draw(spritesheet,positions[x],(x - 1) * 32 + 128, (y - 1) * 32 + 16)
		end
	end
	love.graphics.setColor(1,1,1,190/255)
	love.graphics.rectangle('fill',virtual_width/2-85,virtual_height/3-20,170,140,4)
	love.graphics.setColor(48/255, 96/255, 130/255, 255/255)
	love.graphics.setFont(large)
	love.graphics.printf("GAME OVER",0,virtual_height/3,virtual_width,'center')
	love.graphics.setFont(medium)
	love.graphics.printf("Score: "..tostring(scores),0,virtual_height/3+50,virtual_width,'center')
	love.graphics.setFont(small)
	love.graphics.printf("Press Enter To Play",0,virtual_height/3+80,virtual_width,'center')
end