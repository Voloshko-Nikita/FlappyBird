CoultDownState = class{__includes=BaseState}
COULTDOWN = 0.75

function CoultDownState:init(dt)
    self.count = 3
    self.timer = 0
end

function CoultDownState:update(dt)
    self.timer = self.timer + dt
    if self.timer > COULTDOWN then
        sounds["score"]:play()
        self.count = self.count - 1
        if self.count == 0 then
            gStateMachine:change('play')            
        end
        love.graphics.printf(tostring(self.count), 0, 120,VIRTUAL_WIDTH,'center') 
        self.timer = self.timer % COULTDOWN
    end    
end
function CoultDownState:render()
    love.graphics.setFont(hugefont)
    love.graphics.printf(tostring(self.count), 0, 120,VIRTUAL_WIDTH,'center')
end