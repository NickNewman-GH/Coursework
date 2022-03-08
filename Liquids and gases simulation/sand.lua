Sand = Element:extend()

function Sand:new(x, y)
    Sand.super.new(self, x, y)
    self.color = {0.82, 0.65, 0}
end

function Sand:update(fieldClass, newField, dt)
    if self.y == fieldClass.height then
        newField[self.y][self.x] = self
    elseif fieldClass.field[self.y + 1][self.x] == 0 and newField[self.y + 1][self.x] == 0 then
        self.y = self.y + 1
        newField[self.y][self.x] = self
    else
        isDownLeftReachable = self.x - 1 > 0 and 
        (fieldClass.field[self.y + 1][self.x - 1] == 0 and newField[self.y + 1][self.x - 1] == 0)
        isDownRightReachable = self.x + 1 <= fieldClass.width and 
        (fieldClass.field[self.y + 1][self.x + 1] == 0 and newField[self.y + 1][self.x + 1] == 0)
        if isDownLeftReachable and isDownRightReachable then
            self.y = self.y + 1
            if love.math.random(0,1) == 0 then 
                self.x = self.x - 1
            else
                self.x = self.x + 1
            end
        elseif isDownLeftReachable then
            self.y = self.y + 1
            self.x = self.x - 1
        elseif isDownRightReachable then
            self.y = self.y + 1
            self.x = self.x + 1
        end
        newField[self.y][self.x] = self
    end
end