class=require 'class'
 push=require 'push'
 require 'Ball'
 require 'Paddle'

window_height=720
window_width=1280

virtual_height=243
virtual_width=432


function love.load( )

    math.randomseed(os.time())
    love.window.setTitle('PONG')                --title of game

    love.graphics.setDefaultFilter('nearest','nearest')

    smallFont=love.graphics.newFont('font.ttf',8)
    scoreFont=love.graphics.newFont('font.ttf',24)
    largeFont=love.graphics.newFont('font.ttf',16)

    player1score=0
    player2score=0

    player1=Paddle(15,30,5,20)
    player2=Paddle(virtual_width-15,virtual_height-30,5,20)

    ball=Ball(virtual_width/2-2,virtual_height/2-2,4,4)

    paddlehit= love.audio.newSource("sounds/paddle_hit.mp3","static")
    wallhit= love.audio.newSource("sounds/wall_hit.mp3","static")
    scorehit= love.audio.newSource("sounds/score.mp3","static")

    
    
    push:setupScreen(virtual_width,virtual_height,window_width,window_height,{
        resizable=true,
        fullscreen=false,
        vsync=true,
        canvas=false
    })

    function love.resize(w, h)
        push:resize(w, h)
    end
   
    
    gamestate='start'
    servingplayer=1
end 

function love.update(dt)
    
    
    if love.keyboard.isDown('up') then
        player2:up(dt)
    elseif love.keyboard.isDown('down') then
        player2:down(dt)
    end
    

    if gamestate=='serve' then
        if servingplayer==1 then
            ball.dx=math.random(140,200)
            ball.dy=math.random(-50,50)
            
        elseif servingplayer==2 then
            ball.dx=-math.random(140,200)
            ball.dy=math.random(-50,50)
            
        end

    elseif gamestate=='play' then
        if ball.y>=player1.y then
            player1:down(dt)
        else
            player1:up(dt)
        end

        if ball:collides(player1) then     --collision with left Paddle
            paddlehit:play()      
            ball.dx= -ball.dx*1.03
            ball.x=player1.x+5

            if ball.dy<0 then
                ball.dy= -math.random(-10,150)
            else
                ball.dy=math.random(-10,160)
            end
        end
        if ball:collides(player2) then  --collision with right Paddle  
            paddlehit:play()        
            ball.dx= -ball.dx*1.03         
            ball.x=player2.x-4

            if ball.dy<0 then
                ball.dy= -math.random(-10,160)
            else
                ball.dy=math.random(-10,150)
            end
        end

        if ball.y<=0 then               --if ball collides upper boundary
            ball.y=0
            ball.dy= -ball.dy
            wallhit:play()
        end

        if ball.y>=virtual_height-4 then               --if ball collides lower boundary
            ball.y=virtual_height-4
            ball.dy=-ball.dy
            wallhit:play()
        end

        if ball.x<0 then
            
            player2score=player2score+1
            scorehit:play()
            if player2score==10 then
                gamestate='done'
                winner=2
            else
                ball:reset()
                servingplayer=2
                gamestate='serve'
            end
        end
        if ball.x>virtual_width then
            
            player1score=player1score+1
            scorehit:play()
            if player1score==10 then
                winner=1
                gamestate='done'

            else
                ball:reset()
                servingplayer=1
                gamestate='serve'
            end
        end
    elseif gamestate=='done' then
        ball:reset()
        
        if winner==1 then 
            servingplayer=1
        else
         servingplayer=2
        end

    end

    if gamestate=='play' then
        ball:update(dt)
    end
end

function love.draw()

    push:start()
    

    love.graphics.clear(40/255,45/255,52/255,255/255)
    love.graphics.setFont(smallFont)
        love.graphics.setColor(1,1,1,1)
     if gamestate == 'start' then
        love.graphics.printf('Welcome to Pong!', 0, 10, virtual_width, 'center')
        love.graphics.printf('Press Enter to begin!', 0, 20, virtual_width, 'center')
    elseif gamestate == 'serve' then
        love.graphics.printf('Player ' .. tostring(servingplayer) .. "'s serve!", 0, 10, 
            virtual_width, 'center')
        love.graphics.printf('Press Enter to serve!', 0, 20, virtual_width, 'center')
    elseif gamestate == 'play' then
        -- no UI messages to display in play
    elseif gamestate == 'done' then
        -- UI messages
        
        love.graphics.printf('Player ' .. tostring(winner) .. ' wins!',
            0, 10, virtual_width, 'center')
       
        love.graphics.printf('Press Enter to restart!', 0, 20, virtual_width, 'center')
    end
    

    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1score),virtual_width/2-50,virtual_height/3)
    love.graphics.print(tostring(player2score),virtual_width/2+30,virtual_height/3)

    
    player1:render()   --player1y
    player2:render()   --player2y
    ball:render()


    displayFPS()
    push:finish()
end

function displayFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0,255,0,255)
    love.graphics.print('FPS'..tostring(love.timer.getFPS()),5,5)
end
function love.keypressed(key)
    if key=='escape' then
        love.event.quit()
    elseif key=='enter' or key=='return' then
        if gamestate=='start' then
            gamestate='serve'
        elseif gamestate=='serve' then
            gamestate='play'
        elseif gamestate=='done' then
            gamestate='serve'
            player1score=0
            player2score=0
        end
    end
end