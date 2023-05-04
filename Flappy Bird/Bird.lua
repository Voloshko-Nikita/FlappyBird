Bird = class{}

local GRAVITY = 20

function Bird:init( )
    self.image = love.graphics.newImage('bird.jpg')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)

    self.dy = 0
end

function Bird:update(dt)
    self.dy = self.dy + GRAVITY * dt
    self.y = self.y + self.dy


    if love.keyboard.wasPressed('space') or love.mousepressed() then
        self.dy = -5
        sounds["jump"]:play()
    end
end

function Bird:collides(pipe)
    if (self.x+2) + (self.width-4) >= pipe.x and (self.x + 2) <= pipe.x + PIPE_WIDTH then
        if (self.y + 2) + (self.height - 4)>= pipe.y and (self.y + 2) <= pipe.y  + PIPE_HEIGHT then
            sounds["explosion"]:play()    
            return true 
        end    
    end
    return false
end


function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end