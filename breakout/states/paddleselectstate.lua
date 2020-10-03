paddleselectstate=class{_includes=basestate}

skin=1
size=2

function paddleselectstate:update(dt)
	if love.keyboard.waspressed('escape') then
        love.event.quit()
    end
    if love.keyboard.waspressed('return') then
        gStatemachine:change('serve')
    end

    if love.keyboard.waspressed('left') then
        skin=skin-1
        if skin<1 then
        	skin=4
        end
    end
    if love.keyboard.waspressed('right') then
        skin=skin+1
        if skin>4 then
        	skin=1
        end
    end

end

function paddleselectstate:render()
	love.graphics.setFont(large)
	love.graphics.printf("Select Paddle",0,virtual_height/4,virtual_width,'center')
	love.graphics.setFont(medium)
	love.graphics.printf("Press enter to begin",0,virtual_height/4+40,virtual_width,'center')
	love.graphics.draw(main,gFrames['paddles'][size+4*(skin-1)],virtual_width/2-32,virtual_height-40)
end