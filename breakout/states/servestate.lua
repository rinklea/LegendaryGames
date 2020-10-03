servestate=class{_includes=basestate}
function servestate:init()
		if health==3 or overstate==1 then
			bricks=levelmaker.createmap(level)
		end
		if not shrinkstate then
			paddle=Paddle(skin)
		end
		ball=Ball(math.random(7))	
		scrolling=true
		lockedbrick=Lockedbrick()
end

function servestate:update(dt)
	paddle:update(dt)
	ball:reset()
	if love.keyboard.waspressed('escape') then
        love.event.quit()
    end

    if love.keyboard.waspressed('return') then
        gStatemachine:change('play')
    end
    
end


function servestate:render()
	love.graphics.setFont(medium)
	love.graphics.print("Press Enter To Play",virtual_width-290,160)
	love.graphics.setFont(large)
	love.graphics.print("Level:"..tostring(level),virtual_width-260,120)
	paddle:render()
	ball:render()
	for k,brick in pairs(bricks) do
			brick:render()
	end
	love.graphics.setFont(small)
	love.graphics.print("Score:"..tostring(score),virtual_width-50,5)
	renderhealth(health)
	lockedbrick:render()

end