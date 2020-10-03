
startstate=class{_includes=basestate}
highlighted=2
function startstate:init()
	
	self.colors={
		[1] = {217/255, 87/255, 99/255, 255/255},
        [2] = {95/255, 205/255, 228/255, 255/255},
        [3] = {251/255, 242/255, 54/255, 255/255},
        [4] = {118/255, 66/255, 138/255, 255/255},
        [5] = {153/255, 229/255, 80/255, 255/255},
        [6] = {223/255, 113/255, 38/255, 255/255}
    }
	letters = {
        {'M'},
        {'A'},
        {'T'},
        {'C'},
        {'H'},
        {'3'}
    }
    
	    Timer.every(0.075,function()
	    	self.colors[0]=self.colors[6]
	    	for i=6,1,-1 do
	    		self.colors[i]=self.colors[i-1]
	    	end
	    end)

	    self.transition=40/255

	   
	   positions={}
	   for i=1,64 do
	   	table.insert(positions,tileQuads[math.random(108)])
	   end
end
function startstate:update(dt)
	if love.keyboard.waspressed('up') then
		highlighted=1 
		gSounds['select']:play()    
	elseif love.keyboard.waspressed('down') then
		highlighted=2
		gSounds['select']:play()
    end
    if highlighted==1 and love.keyboard.waspressed('return')then
    	self.yes=true
    end
    if highlighted==2 and love.keyboard.waspressed('return')then
        love.event.quit()
    end 
    Timer.update(dt)
end

function startstate:render( )
	love.graphics.setColor(1,1,1, 128/255)
	love.graphics.draw(background,-backgroundx,0)
	 love.graphics.setColor(1,1,1, 255/255)
	for y=1,8 do
		for x=1,8 do	
			love.graphics.draw(spritesheet,positions[x],(x - 1) * 32 + 128, (y - 1) * 32 + 16)
		end
	end
	self:shadow()
    self:text()
    self:options()
    if self.yes then
    	self:whitetransition()
    end 

end

function startstate:text()
	love.graphics.setColor(1,1,1,190/255)
	love.graphics.rectangle('fill',virtual_width/2-75,virtual_height/3-40,150,65,4)
	love.graphics.setFont(large)
	for i=1,6 do
		love.graphics.setColor(self.colors[i])
		love.graphics.print(letters[i],(i*25)+virtual_width/2-95,virtual_height/3-20)
	end
	
end

function startstate:options()
	love.graphics.setColor(1,1,1,190/255)
	love.graphics.rectangle('fill',virtual_width/2-75,virtual_height-120,150,65,4)
	love.graphics.setFont(medium)

	love.graphics.setColor(70/255, 120/255, 255/255, 255/255)
	if highlighted==1 then
		love.graphics.setColor(48/255, 96/255, 130/255, 255/255)
	end
	love.graphics.printf("START GAME",0,virtual_height-110,virtual_width,'center')
	love.graphics.setColor(70/255, 120/255, 255/255, 255/255)
	if highlighted==2 then
		love.graphics.setColor(48/255, 96/255, 130/255, 255/255)
	end
	love.graphics.printf("EXIT GAME",0,virtual_height-80,virtual_width,'center')
	love.graphics.setColor(70/255, 120/255, 255/255, 255/255)	
	 love.graphics.setColor(1,1,1,1)
end

function startstate:shadow()
	love.graphics.setColor(0, 0, 0, 128/255)
    love.graphics.rectangle('fill', 0, 0, virtual_width,virtual_height)
  
end

function startstate:whitetransition()
	Timer.tween(1,{
    		[self]={transition=1}
    		}):finish(function() 
    		gStatemachine:change('level')
    	end)
	love.graphics.setColor(1,1,1,self.transition)
    love.graphics.rectangle('fill', 0, 0, virtual_width,virtual_height)
end








