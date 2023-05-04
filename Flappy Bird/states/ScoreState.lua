ScoreState = class{__includes = BaseState}

function ScoreState:init(dt)
    if score > max_score then
        max_score = score
    end
end

function ScoreState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('title')
    end    
end

function ScoreState:render()
    love.graphics.setFont(flappyfont)
    love.graphics.printf("YOU LOST", 0, 20,VIRTUAL_WIDTH,'center') 
    love.graphics.printf("Your score: " .. tostring(score), 0, 60,VIRTUAL_WIDTH,'center')
    love.graphics.printf("Best score: " .. tostring(max_score), 0, 100,VIRTUAL_WIDTH,'center')
    
    love.graphics.setFont(mediumfont)
    love.graphics.printf('Press ENTER', 0, 130,VIRTUAL_WIDTH,'center')
end