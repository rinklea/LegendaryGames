Paddle=class{}

function Paddle:init(x,y,width,height)
	self.x=x
	self.y=y
	self.width=width
	self.height=height

	self.paddle_speed=200
end

function Paddle:up(dt)
	self.y=math.max(0,self.y+ -self.paddle_speed*dt)
end

function Paddle:down(dt)
	self.y=math.min(virtual_height-20,self.y+ self.paddle_speed*dt)
end

 function Paddle:render()
 	love.graphics.rectangle('fill',self.x,self.y,self.width,self.height)
 end
