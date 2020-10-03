Pipe= Class{}


local pipe_image=love.graphics.newImage('pipe.png')
local pipe_scroll=-60

pipe_height=288
pipe_width=70



function Pipe:init(y)
	self.scored=false
	self.x=virtual_width
	self.y=y
	self.width=pipe_image:getWidth()
	self.height=pipe_image:getWidth()
end

function Pipe:update(dt)
	self.x=self.x+pipe_scroll*dt
	if bird.y+bird.height>virtual_height-16 or bird.y<0 then
		gStatemachine:change('score')
		sounds['collision']:play()
		scrolling=true
		bird.y=virtual_height/2-(self.height/2)
	end

	if bird.x<=self.x+pipe_width and bird.x+bird.width>=self.x then
		if (bird.y>=self.y and bird.y+bird.height<=pipe_gap+self.y) or (bird.y+bird.height <=self.y and bird.y>=self.y-pipe_gap)then
			return false
		else
			return true
		end
	end
end
 
function Pipe:render(o)
	if o==1 then
 		love.graphics.draw(pipe_image,self.x,self.y,0,1,-1)
 	else
 		love.graphics.draw(pipe_image,self.x,self.y,0,1,1)
 	end
end
 