startstate=class{_includes=basestate}
highlighted = 2


function startstate:update(dt)
	if love.keyboard.waspressed('up') then
		highlighted=1     
	elseif love.keyboard.waspressed('down') then
		highlighted=2
    end
    if love.keyboard.waspressed('escape') then
        love.event.quit()
    end
    if highlighted==1 and love.keyboard.waspressed('return')then
        gStatemachine:change('paddleselect')
    end
    if highlighted==2 and love.keyboard.waspressed('return')then
        gStatemachine:change('highscore')
    end

end


function startstate:render()
	love.graphics.setFont(large)
	love.graphics.print('BREAKOUT',140,virtual_height/3-40)
	love.graphics.setFont(medium)
	if highlighted==1 then
		love.graphics.setColor(1,102/255,1,1)
	end
	love.graphics.print('PLAY',200,virtual_height/2+70)
	love.graphics.setColor(1,1,1,1)
	if highlighted==2 then
		love.graphics.setColor(1,102/255,1,1)
	end
	love.graphics.print('HIGH SCORES',170,virtual_height/2+90)
	love.graphics.setColor(1,1,1,1)	
end