scorestate=Class{_include=basestate}

 function scorestate:update(dt)
 	if love.keyboard.waspressed('return')  then
 		scrolling=true
 		gStatemachine:change('count')
 	end
 end

function scorestate:render(o)
	love.graphics.setFont(titlefont)
	love.graphics.printf("HAHA, YOU LOSER",0,64,virtual_width,'center')
	love.graphics.setFont(mediumfont)
	love.graphics.printf("score:"..tostring(score),0,100,virtual_width,'center')
	love.graphics.printf("YOU ARE AWARDED WITH ",0,150,virtual_width,'center')
	if score<=10 then
		bronze=love.graphics.newImage('bronze.png')
		love.graphics.draw(bronze,330,150)
	elseif score>10 and score <=20 then
		silver=love.graphics.newImage('silver.png')
		love.graphics.draw(silver,330,150)
	elseif score>30 then
		gold=love.graphics.newImage('gold.png')
		love.graphics.draw(gold,330,150)
	end
	love.graphics.printf("Press enter to restart",0,200,virtual_width,'center')
end

