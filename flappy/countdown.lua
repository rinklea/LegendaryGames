countdown =Class{_includes=basestate}

count_down=0.75
function countdown:init()
	self.timer=0
	self.count=3
end

function countdown:update(dt)

	self.timer=self.timer+dt

	if self.timer>=count_down then
		self.count=self.count-1
		self.timer=self.timer%count_down

		if self.count==0 then
			gStatemachine:change('play')
		end
	end
	
end

function countdown:render(o)
	countfont=love.graphics.newFont('flappy.ttf',56)
	love.graphics.setFont(countfont)
	love.graphics.printf(tostring(self.count),0,110,virtual_width,'center')
end
