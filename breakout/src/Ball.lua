Ball=class{}

function Ball:init(skin)
	self.x=paddle.x+(paddle.width/2)-4
	self.y=virtual_height-40
	self.dx=math.random(100,200)
	self.dy=math.random(-80,-90)
	self.width=8
	self.height=8
	self.skin=skin
end

function Ball:reset()
	self.x=paddle.x+(paddle.width/2)-4
	self.y=virtual_height-40
	self.dx=math.random(100,200)
	self.dy=math.random(-80,-90)
end

function Ball:update(dt)
	self.x=self.x+self.dx*dt
	self.y=self.y+self.dy*dt
	if self.x<=0 then
		self.x=0
		self.dx=-self.dx
		if self.dy<0 then 
			self.dy=math.random(-80,-90)
		else
			self.dy=math.random(80,90)
		end
	end
	if self.x>=virtual_width-8 then
		self.x=virtual_width-8
		self.dx=-self.dx
		if self.dy<0 then 
			self.dy=math.random(-80,-90)
		else
			self.dy=math.random(80,90)
		end
		
	end
	if self.y<=0 then
		self.y=0
		self.dy=-self.dy
	end
end

function Ball:collide(target)
	if self.x>target.x+target.width or self.x+self.width<target.x then 
		return false
	end
	if self.y>target.y+target.height or self.y+self.height<target.y then 
		return false
	end
	return true
end

function Ball:render()
	love.graphics.draw(main,gFrames['balls'][self.skin],self.x,self.y)
end
