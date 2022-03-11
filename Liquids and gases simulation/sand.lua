Sand = Element:extend()

function Sand:new(x, y)
    Sand.super.new(self, x, y)
    self.color = {0.82, 0.65, 0}
end

function Sand:update(fieldClass, newField, dt)
    isLowerBound = self.y == fieldClass.height

    if not isLowerBound then
        isDownReachable = self.y < fieldClass.height and 
        (fieldClass.field[self.y + 1][self.x] == 0 and newField[self.y + 1][self.x] == 0)
        if isDownReachable then
            for i=1,self.gravity do
                self.y = self.y + 1
                isDownReachable = self.y < fieldClass.height and 
                (fieldClass.field[self.y + 1][self.x] == 0 and newField[self.y + 1][self.x] == 0)
                isLowerBound = self.y == fieldClass.height
                if (not isDownReachable) or isLowerBound then
                    break
                end
            end
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
        end
    end
    newField[self.y][self.x] = self
end