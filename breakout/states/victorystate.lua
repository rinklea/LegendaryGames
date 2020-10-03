victorystate=class{_includes=basestate}

function victorystate:init()
	overstate=1       --to create new level in servestate
	shrinkstate=false
end

function victorystate:update(dt)	  
	if love.keyboard.waspressed('escape') then
        love.event.quit()
    end
    if love.keyboard.waspressed('return') then
        gStatemachine:change('serve')
    end
    
 end

 function victorystate:render()
 	love.graphics.setFont(medium)
	love.graphics.printf("Press Enter To Play",0,160,virtual_width,'center')
	love.graphics.setFont(large)
	love.graphics.printf("Level: "..tostring(levels).."  Complete",0,120,virtual_width,'center')
 end