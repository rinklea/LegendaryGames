Paddle=class{}
function Paddle:init(skin)
	self.paddle_speed=300
	self.x=virtual_width/2-16
	self.y=virtual_height-32
	self.dx=0
	self.height=16
	self.width=64
	self.size=2
end

function Paddle:update(dt)
	if love.keyboard.isDown('left') then
		self.dx=-self.paddle_speed*dt
	elseif love.keyboard.isDown('right') then
		self.dx=self.paddle_speed*dt
	else
		self.dx=0
	end
	self.x=self.x+self.dx
	if self.x<=0 then
		self.x=0
	elseif self.x+self.width>=virtual_width then
		self.x=virtual_width-self.width
	end	
end

function Paddle:grow()
	if self.size<4 then
		self.size=self.size+1
		self.width=self.width+32
		self.x=self.x-16
	end
end

function Paddle:shrink()
	if self.size>1 then
		self.size=self.size-1
		self.width=self.width-32
		self.x=self.x+16
	end
end

function Paddle:render( )
	love.graphics.draw(main,gFrames['paddles'][self.size+4*(skin-1)],self.x,self.y)
end
	