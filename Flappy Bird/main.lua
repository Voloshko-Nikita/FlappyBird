push = require 'push'
class = require 'class'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 523
VIRTUAL_HEIGHT = 260

require 'Bird' 
require 'Pipe' 
require 'PipePair' 

require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/ScoreState'
require 'states/TitleScreenState'
require 'states/CoultDownState'


local bird = Bird()
local pipe = Pipe()

local background = love.graphics.newImage('background.png')
local backgroundScroll = 0
local BACKGROUND_SCROLL_SPEED = 30
local BACKGROUND_LOOP_POINT = 413

local ground = love.graphics.newImage('ground.png')
local groundScroll = 0
local GROUND_SCROLL_SPEED = 60
local GROUND_LOOP_POINT = 413


--local pipePairs = {}
--local spawnTimer = 0
--local timer_random = math.random(3)

local scrolling = true

--local lastY = -PIPE_HEIGHT + math.random(80) + 20 

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Flappy bird')
    song = 1

    sounds = {
        ["hurt"] = love.audio.newSource("hurt.wav","static"),
        ["explosion"] = love.audio.newSource("explosion.wav","static"),
        ["jump"] = love.audio.newSource("jump.wav","static"),
        ["score"] = love.audio.newSource("score.wav","static"),
   
        ["sans"] = love.audio.newSource("sans.mp3","static"),
        ["aha"] = love.audio.newSource("Take On Me.mp3","static"),
        ["poc"] = love.audio.newSource("POC.wav","static"),
    }

    smallfont = love.graphics.newFont('font.ttf', 8)
    mediumfont = love.graphics.newFont('flappy.ttf', 14)
    flappyfont = love.graphics.newFont('flappy.ttf', 28)
    hugefont = love.graphics.newFont('flappy.ttf', 56)
    love.graphics.setFont(flappyfont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
        vsync = true,
        resizable = true,
        fullscreeen = false
    })

    gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end,
        ['coultdown'] = function() return CoultDownState() end,
    }
    gStateMachine:change('title')

    love.keyboard.keysPressed = {}
end

function love.resize(w,h)     
    push:resize(w,h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
    if key == 'escape' then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed [key] then
        return true
    else
        return false
    end
end

function love.mousepressed(x,y,button)
    if button == 1 or button == 2 or button == 3 then
        return true
    end
    return false
end


function love.update(dt)
    if scrolling then 
        backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
            % BACKGROUND_LOOP_POINT
        groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt)
            % VIRTUAL_WIDTH

        gStateMachine:update(dt)
        love.keyboard.keysPressed = {}
    end
end

function love.draw()
    push:start()
        love.graphics.draw(background, -backgroundScroll, 0)

        gStateMachine:render()

        love.graphics.draw(ground,-groundScroll, VIRTUAL_HEIGHT-16)

    push:finish()
end