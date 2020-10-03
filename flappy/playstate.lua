playstate=Class{_includes=basestate}

function playstate:init()
	if scrolling then 
	     pipestop={}
		 pipesdown={}
	     spawntimer = 0
	     score=0
	     
	end
end

function playstate:update(dt)
		 spawntimer= spawntimer+dt 
		    if  spawntimer>math.random(2,3) then
		        y1=math.random(30,virtual_height/2)
		        table.insert( pipestop,Pipe(y1))
		        table.insert( pipesdown,Pipe(y1+pipe_gap))
		         spawntimer=0
		    end


			bird:update(dt)

		    for k,pipe in pairs( pipestop) do
		    	if pipe.scored==false then
			    	if bird.x>pipe.x+67 then
			    		sounds['score']:play()
						score=score+1
						pipe.scored=true
					end
				end
		        if pipe:update(dt) then
		        	sounds['collision']:play()
		        	gStatemachine:change('score')
		        end	        
		        if pipe.x + pipe.width < 0 then
		            table.remove( pipestop,k)
		        end
		    end

		    for k,pipe in pairs( pipesdown) do
		        if pipe:update(dt) then
		        	gStatemachine:change('score')
		        end
		        
		        if pipe.x + pipe.width < 0 then
		            table.remove( pipesdown,k)
		        end
		    end

		    if love.keyboard.waspressed('p') then
		    	sounds['music']:stop()
		    	sounds['pause']:play()
		    	scrolling=false
		    	gStatemachine:change('pause')
		    end

end

function playstate:render(o)
	for k,pipe in pairs( pipestop) do
        pipe:render(1)
    end
    love.graphics.setFont(scorefont)
	love.graphics.print("Score:"..tostring(score),0,10)
    for k,pipe in pairs( pipesdown) do
        pipe:render(0)
    end
    bird:render(o)
end