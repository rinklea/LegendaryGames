Lockedbrick=class{}
state=false
function Lockedbrick:init()
	self.x=lockedrow
	self.y=lockedcol
	self.lock=true
	self.width=32
	self.height=16
	self.color=1
	self.tier=0
	self.visible=true
end

function Lockedbrick:hit()
	self.color=self.color+1
	if self.color>5 then
		self.visible=false
	end
end

function Lockedbrick:render( ... )
	if state and self.visible then
		love.graphics.draw(main,gFrames['bricks'][(self.color-1)*4+self.tier+1],self.x,self.y)
	end
	if state==false then
    	love.graphics.draw(main,gFrames['bricks'][22],self.x,self.y)
    end
end