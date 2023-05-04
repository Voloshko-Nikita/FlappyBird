TitleScreenState = class{__includes = BaseState}

function TitleScreenState:init()
    love.audio.stop()
    song = math.random(0,3)
    if song == 1 then
        sounds["aha"]:setLooping(true)
        sounds["aha"]:play()
    song = math.random(3)
    elseif song == 2 then
        sounds["sans"]:setLooping(true)
        sounds["sans"]:play()     
    elseif song == 3 then
        sounds["poc"]:setLooping(true)
        sounds["poc"]:play()
    end
end

function TitleScreenState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('coultdown')
    end    
end

function TitleScreenState:render()
    love.graphics.setFont(flappyfont)
    love.graphics.printf('Flappy Bird', 0, 40,VIRTUAL_WIDTH,'center')
    
    love.graphics.setFont(mediumfont)
    love.graphics.printf('Press ENTER', 0, 100,VIRTUAL_WIDTH,'center')
end
