Powerup=class{}

function Powerup:init()
	self.x=math.random(16,virtual_width-16)
	self.y=math.random(30,70)
	self.dy=0
	powerspeed=2
	self.width=16
	self.height=16
	self.visible=true
end

function Powerup:update(dt)
	self.dy=self.dy+powerspeed*dt
	self.y=self.y+self.dy	
end

function Powerup:collide(target)
	if self.x>target.x+target.width or self.x+self.width<target.x then 
		return false
	end
	if self.y>target.y+target.height or self.y+self.height<target.y then 
		return false
	end
	return true
end

function Powerup:hit()
	self.visible=false
end


function Powerup:render()
	if self.visible then
		if color==1 then
			love.graphics.draw(main,gFrames['power'][9],self.x,self.y)
		elseif color==2 then
			love.graphics.draw(main,gFrames['power'][10],self.x,self.y)
		end
 	end
end