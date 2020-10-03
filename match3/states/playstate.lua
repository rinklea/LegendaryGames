playstate=class{_includes=basestat}

function playstate:init()
	yes=false
	timer=0
	count=60
	highlight=false
	highlightx=1
	highlighty=1
	self.selectedtile=board.tiles[1][1]
end

function playstate:update(dt)
	timer=timer+dt
	if timer>1 then
		count=count-1
		if count<=5 then
			gSounds['clock']:play()
		end
		timer=0
	end
	if love.keyboard.waspressed('escape') then
        love.event.quit()
    end
   	self:highlighted()
    Timer.update(dt)
    if board:calculateMatches() then
    	gSounds['match']:play()
		score=score+150
		count=count+3
		self:calculatematches()
	end
	scores=score
	if score<=goal and count==0 then
		gSounds['game-over']:play()
		gStatemachine:change('gameover')
	end
	if score>=goal and count>0 then
		level=level+1
		goal=goal+500
		gSounds['next-level']:play()
		gStatemachine:change('level')
	end	

	if self:moves() == 0 then
		gSounds['next-level']:play()
		board=Board(virtual_width - 272, 16,1)
		board:render()
	end

end



function playstate:calculatematches()
	board:removeMatches()
	local tilesToFall =board:getFallingTiles()
        Timer.tween(0.25, tilesToFall):finish(function()
            board:calculateMatches()
        end)
	
end

function playstate:highlighted()
		startx={}
		starty={}
		x1,y1=self.selectedtile.gridx,self.selectedtile.gridy
		for i=272,48,-32 do
			table.insert(startx,virtual_width-i)
		end
		for i=16,512,32 do
			table.insert(starty,i)
		end

		if love.mouse.isDown(1) then
			for i=1,8 do
				if mousex>=startx[i] and mousex<startx[i]+32 then
					x1=i
				end
			end
			for i=1,8 do
				if mousey>=starty[i] and mousey<starty[i]+32 then
					y1=i
				end
			end

			self.selectedtile=board.tiles[y1][x1]	
			if not highlight then
				highlight=true
				highlightx,highlighty=self.selectedtile.gridx,self.selectedtile.gridy
			else
				self:swaptiles(board.tiles[highlighty][highlightx],self.selectedtile)
				highlight=false	
			end
 	 	end
end


function playstate:swaptiles(tile1,tile2)
	 tile1=tile1
	 tile2=tile2

	 if (tile1.x==tile2.x+32 or tile1.x==tile2.x-32 and tile1.y==tile2.y) or 
	 	(tile1.y==tile2.y+32 or tile1.y==tile2.y-32 and tile1.x==tile2.x) and not
	 	(tile1.x==tile2.x+32 and tile1.y==tile2.y+32) and not
	 	(tile1.x==tile2.x-32 and tile1.y==tile2.y+32) and not 
	 	(tile1.x==tile2.x+32 and tile1.y==tile2.y-32) and not 
	 	(tile1.x==tile2.x-32 and tile1.y==tile2.y-32) then

		tempx,tempy=tile2.x,tile2.y
		tempgridx,tempgridy=tile2.gridx,tile2.gridy

		temp=tile1
		board.tiles[tile1.gridy][tile1.gridx]=tile2
		board.tiles[tile2.gridy][tile2.gridx]=temp				

		Timer.tween(0.25, {
		    [tile2] = {x = tile1.x, y = tile1.y},
		    [tile1] = {x = tempx, y = tempy}
		    })

		tile2.gridx,tile2.gridy=tile1.gridx,tile1.gridy
		tile1.gridx,tile1.gridy=tempgridx,tempgridy

		highlight=false
		self.selectedtile=tile1
	else
		
		highlight=false
	end
end

function playstate:moves()
	moves=0
	for y=1,7 do 			--horizontal moves
		for x=1,7 do
			temp=board.tiles[y][x]
			board.tiles[y][x]=board.tiles[y][x+1]
			board.tiles[y][x+1]=temp

			if board:calculateMatches() then
				moves=moves+1
			end

			board.tiles[y][x+1]=board.tiles[y][x]
			board.tiles[y][x]=temp
		end
	end
	for x=1,7 do 				--vertical moves
		for y=1,7 do
			temp=board.tiles[y][x]
			board.tiles[y][x]=board.tiles[y+1][x]
			board.tiles[y+1][x]=temp

			if board:calculateMatches() then
				moves=moves+1
			end

			board.tiles[y+1][x]=board.tiles[y][x]
			board.tiles[y][x]=temp
		end
	end
	return moves

end

function playstate:render()
	love.graphics.setColor(1,1,1,1)
	love.graphics.draw(background,-backgroundx,0)
	board:render()
	
	love.graphics.setColor(56/255, 56/255, 56/255, 234/255)
    love.graphics.rectangle('fill', 16, 16, 186, 138, 4)	

    love.graphics.setColor(99/255, 155/255, 255/255, 255/255)
    love.graphics.setFont(medium)
    love.graphics.printf('Level: ' .. tostring(level), 20, 24, 182, 'center')
    love.graphics.printf('Score: ' .. tostring(score), 20, 52, 182, 'center')
    love.graphics.printf('Goal : ' .. tostring(goal), 20, 80, 182, 'center')
    love.graphics.printf('Timer: ' .. tostring(count), 20, 108, 182, 'center')
    love.graphics.printf('Moves: ' .. tostring(moves), 20, 135, 182, 'center')


    for y=1,8 do
    	for x=1,8 do
    		local tile=board.tiles[y][x]
			if highlight then
				if tile.gridx==highlightx and tile.gridy==highlighty then
					love.graphics.setColor(1,1,1,123/255)
					love.graphics.rectangle('fill',tile.x+virtual_width-272,tile.y+16,32,32,4)
					love.graphics.setColor(1,1,1,1)
				end
		 	end
		end
	end
	love.graphics.rectangle('line',self.selectedtile.x+virtual_width-272,self.selectedtile.y+16,32,32,4)
	love.graphics.setLineWidth(1)	
	love.graphics.setColor(1,1,1,1)	
end




















 
