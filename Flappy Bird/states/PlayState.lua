PlayState = class{__includes=BaseState}

PIPE_SPEED = 60
PIPE_HEIGHT = 288
PIPE_WIDTH = 70
max_score = 0
function PlayState:init()
    score = 0
    self.bird = Bird()
    self.pipePairs = {}
    self.spawnTimer = 0
    self.timer_random = math.random(3)

    self.lastY = -PIPE_HEIGHT + math.random(80) + 20 
end

function PlayState:update(dt)

    self.spawnTimer = self.spawnTimer + dt

    if self.spawnTimer > self.timer_random then
        
        local y = math.max(-PIPE_HEIGHT+10, math.min(self.lastY + math.random(-20, 20), VIRTUAL_HEIGHT-10-PIPE_HEIGHT))
        self.lastY = y

        table.insert(self.pipePairs, PipePair(y))
        self.timer_random = math.random(2, 3)
        self.spawnTimer = 0
    end
    

    for k, pipe in pairs(self.pipePairs) do

        if not pipe.scored then
            if pipe.x + PIPE_WIDTH < self.bird.x then
                score = score + 1
                pipe.scored = true
                sounds["score"]:play()
            end
        end

        pipe:update(dt)
    end
    

    for k, pair in pairs(self.pipePairs) do
        if pair.remove then
            table.remove(self.pipePairs, k)
        end
    end

    self.bird:update(dt)
    love.graphics.printf(tostring(score), 0, 10,VIRTUAL_WIDTH,'center')  

    for k, pair in pairs(self.pipePairs) do
        for l, pipe in pairs(pair.pipes) do
            if (self.bird:collides(pipe)) then
                sounds["hurt"]:play()
                sounds["explosion"]:play()
                gStateMachine:change('score')
            end
        end
    end

    if (self.bird.y+self.bird.height >= VIRTUAL_HEIGHT-16) then
        sounds["hurt"]:play()
        gStateMachine:change('score')
    end
end


function PlayState:render()
    for k, pipe in pairs(self.pipePairs) do
        pipe:render()
    end
    self.bird:render()  
    love.graphics.setFont(flappyfont)
    love.graphics.print("Score: " .. tostring(score), 8,8)
end
