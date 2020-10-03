class=require "lib/class"
push=require "lib/push"
Timer = require 'lib/knife.timer'
require 'lib.Util'
require 'states/statemachine'
require 'states/basestate'
require 'states/startstate'
require 'states/levelstate'
require 'states/playstate'
require 'states/gameoverstate'
require 'src/Board'
require 'src/Tiles'



window_width=1280
window_height=720
virtual_width=512
virtual_height=298

function love.load()
	score=0
	level=1
	goal=500
	backgroundx=0
	backgroundspeed=60
	love.window.setTitle("MATCH3")
	math.randomseed(os.time())
	love.graphics.setDefaultFilter('nearest','nearest')

	small=love.graphics.newFont('fonts/font.ttf',8)
	medium=love.graphics.newFont('fonts/font.ttf',16)
	large=love.graphics.newFont('fonts/font.ttf',32)

	spritesheet=love.graphics.newImage('images/match3.png')
	background=love.graphics.newImage('images/background.png')
	particle=love.graphics.newImage('images/particle.png')

	tileQuads=GenerateQuads(spritesheet,32,32)
	colorquads=GenerateTileQuads(spritesheet)
	color={1,2,5,6,9,10,13,14,17,18}

	gSounds = {
    ['music'] = love.audio.newSource('sounds/music3.mp3','static'),
    ['select'] = love.audio.newSource('sounds/select.wav','static'),
    ['error'] = love.audio.newSource('sounds/error.wav','static'),
    ['match'] = love.audio.newSource('sounds/match.wav','static'),
    ['clock'] = love.audio.newSource('sounds/clock.wav','static'),
    ['game-over'] = love.audio.newSource('sounds/game-over.wav','static'),
    ['next-level'] = love.audio.newSource('sounds/next-level.wav','static')
	}

	gSounds['music']:setLooping(true)
    gSounds['music']:play()

	push:setupScreen(virtual_width,virtual_height,window_width,window_height,{
        resizable=true,
        fullscreen=false,
        vsync=true,
        canvas=false
    })
	function love.resize(w,h)
		push:resize(w,h)
	end

	love.keyboard.keyspressed={}

	gStatemachine=statemachine{
		['start']=function() return startstate() end,
		['level']=function() return levelstate() end,
		['play']=function() return playstate() end,
		['gameover']=function() return gameoverstate() end
	}
	gStatemachine:change('start')
end

function love.update(dt)
	if love.keyboard.waspressed('escape') then
		love.event.quit()
	end	
	gStatemachine:update(dt)
	love.keyboard.keyspressed={}
	backgroundx=(backgroundx+backgroundspeed*dt)%virtual_width	
	
end


function love.draw()
	push:start()
	gStatemachine:render()
	mousex,mousey=love.mouse.getPosition()
	mousex,mousey=push:toGame(mousex,mousey)


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

