class=require "lib/class"
push=require "lib/push"
require 'states/Statemachine'
require 'states/basestate'
require 'states/startstate'
require 'states/playstate'
require 'states/pausestate'
require 'states/servestate'
require 'states/gameoverstate'
require 'states/victorystate'
require 'states/paddleselectstate'
require 'src/util'
require 'src/Paddle'
require 'src/Ball'
require 'src/Brick'   
require 'src/levelmaker'
require 'src/Powerup'
require 'src/Lockedbrick'



window_width=1280
window_height=720
virtual_width=432
virtual_height=243

scrolling=true
score=0
level=1
overstate=0
health=3


function love.load()

	
	love.window.setTitle("BREAKOUT")
	math.randomseed(os.time())
	love.graphics.setDefaultFilter('nearest','nearest')

	background=love.graphics.newImage('images/background.jpg')
	main=love.graphics.newImage('images/breakout.png')
	particle=love.graphics.newImage('images/particle.png')

	small=love.graphics.newFont('fonts/font.ttf',8)
	medium=love.graphics.newFont('fonts/font.ttf',16)
	large=love.graphics.newFont('fonts/font.ttf',32)

	

	gFrames={
		['paddles']=generatequadpaddles(main),
		['bricks']=generatequadbricks(main),
		['balls']=generatequadballs(main),
		['health']=generatequadhealth(main),
		['power']=generatequadpower(main)
	}

	push:setupScreen(virtual_width,virtual_height,window_width,window_height,{
        resizable=true,
        fullscreen=false,
        vsync=true,
        canvas=false
    })
	function love.resize(w,h)
		push:resize(w,h)
	end

	gStatemachine=Statemachine{
		['start']=function() return startstate() end,
		['play']=function() return playstate() end,
		['pause']=function() return pausestate() end,
		['serve']=function() return servestate() end,
		['gameover']=function() return gameoverstate() end,
		['victory']=function() return victorystate() end,
		['paddleselect']=function() return paddleselectstate() end,
		['highscore']=function() return highscorestate() end,
		['enterhighscore']=function() return enterhighscorestate() end
	}
	gStatemachine:change('start')
	love.keyboard.keyspressed={}
end

function love.update(dt)
	gStatemachine:update(dt)
	love.keyboard.keyspressed={}
end


function love.draw()
	push:start()
	background_width=background:getWidth()
	background_height=background:getHeight()
	love.graphics.draw(background,0,0,0,virtual_width/background_width,virtual_height/background_height)

	gStatemachine:render()
	
	push:finish()
	
end

function love.keypressed(key)
	love.keyboard.keyspressed[key]=true
end

function love.keyboard.waspressed(key)
	if love.keyboard.keyspressed[key]==true then
		return true
	else
		return false
	end
end

function renderhealth(health)
	healthx=virtual_width-80
	for i=1,health do
		love.graphics.draw(main,gFrames['health'][1],healthx,5)
		healthx=healthx-10
	end
	for i=1,3-health do
		love.graphics.draw(main,gFrames['health'][2],healthx,5)
		healthx=healthx-10
	end
end
