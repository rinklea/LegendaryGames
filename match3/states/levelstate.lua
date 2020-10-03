levelstate=class{_includes=basestate}
 
function levelstate:init()
	self.variety=1
	board=Board(virtual_width - 272, 16,self.variety)
	self.transition=1
	self.recty=-40
	Timer.after(0,function()
		Timer.tween(.75,{
			[self]={recty=virtual_height/2-20},
		}):finish(function()
		Timer.after(1,function()
		Timer.tween(.75,{
			[self]={recty=virtual_height+30},			
		})	
	end)
	end)
	end) 
	
		
end

function levelstate:update(dt)
	Timer.update(dt)
	if self.recty==virtual_height+30 then
		gStatemachine:change('play')
	end
	
end

function levelstate:render()
    love.graphics.setColor(1,1,1,1)
	love.graphics.draw(background,-backgroundx,0)
	board:render()
	love.graphics.setColor(95/255, 205/255, 228/255, 200/255)
	love.graphics.rectangle('fill',0,self.recty,virtual_width,40)
	love.graphics.setFont(large)
	love.graphics.setColor(1,1,1,1)
	love.graphics.printf("Level: "..tostring(level),0,self.recty+9,virtual_width,'center')	
end