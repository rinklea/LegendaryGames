Class=require 'Class'
push=require 'push'

require 'Bird'
require 'Pipe'

require 'Statemachine'
require 'titlestate'
require 'basestate'
require 'playstate'
require 'countdown'
require 'scorestate'
require 'pausestate'

window_width=1280
window_height=720

virtual_width=512
virtual_height=288

local background=love.graphics.newImage('background.png')
local ground=love.graphics.newImage('ground.png')

pipe_gap=math.random(60,100)

background_scroll=0
ground_scroll=0

background_speed=30
ground_speed=60

bird=Bird()


background_loop=413


function love.load()

    sounds = {
        ['jump'] = love.audio.newSource('jump.wav', 'static'),
        ['collision'] = love.audio.newSource('collision.wav', 'static'),
        ['score'] = love.audio.newSource('score.wav', 'static'),
        ['music'] = love.audio.newSource('music.mp3', 'static'),
        ['pause'] = love.audio.newSource('pause.mp3', 'static')
    }
        sounds['music']:setLooping(true)
        sounds['music']:play()

    titlefont=love.graphics.newFont('flappy.ttf',28)
    mediumfont=love.graphics.newFont('flappy.ttf',14)
    scorefont=love.graphics.newFont('flappy.ttf',32)

    pipestop={}
    pipesdown={}
    spawntimer = 0
    score=0

    

	gStatemachine=Statemachine{
		['title']=function() return titlestate() end,
		['play']=function() return playstate() end,
        ['count']=function() return countdown() end,
        ['score']=function() return scorestate() end,
        ['pause']=function() return pausestate() end
	}
	gStatemachine:change('title')

    love.graphics.setDefaultFilter('nearest','nearest')
    love.window.setTitle('FLAPPY BIRD')

    math.randomseed(os.time())
    
    
    push:setupScreen(virtual_width,virtual_height,window_width,window_height,{
        resizable=true,
        fullscreen=false,
        vsync=true,
        canvas=false
    })

    love.keyboard.keyspressed={}
    function love:resize(w, h) 
        push:resize(w, h)
    end
end



function love.update(dt)
	    background_scroll=(background_scroll+background_speed*dt)%background_loop
	    ground_scroll=(ground_scroll+ground_speed*dt)%virtual_width

	    gStatemachine:update(dt)
        love.keyboard.keyspressed={}
end


function love.draw()
    push:start()

	love.graphics.draw(background,-background_scroll,0)
    gStatemachine:render(o)
    love.graphics.draw(ground,-ground_scroll,virtual_height-16)
    
    push:finish()
end

function love.keypressed(key)
    love.keyboard.keyspressed[key]=true
    if key=='escape' then
        love.event.quit()
    end
end

function love.keyboard.waspressed(key)
    if love.keyboard.keyspressed[key] then
        return true
    else
        return false
    end
end