Bird=Class{}

local gravity=20
local jump=20

function Bird:init()
 	self.image=love.graphics.newImage('bird.png')
 	self.width=self.image:getWidth()
 	self.height=self.image:getHeight()
 	self.x=virtual_width/2-(self.width/2)
 	self.y=virtual_height/2-(self.height/2)
 	self.dy=0
end

function Bird:update(dt)
	self.dy=self.dy+gravity*dt
	if bird.y+bird.height>virtual_height-16 then
		gStatemachine:change('score')
		sounds['collision']:play()
		scrolling=true
		bird.y=virtual_height/2-(self.height/2)
	end
    if love.keyboard.waspressed('space') then
    	self.dy=-2
    	sounds['jump']:play()
    end
    self.y=self.y+self.dy   
end


function Bird:render(o)
 	love.graphics.draw(self.image,self.x,self.y)
end