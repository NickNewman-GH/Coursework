Water = Element:extend()

function Water:new(x, y)
    Water.super.new(self, x, y)
    self.color = {0, 0.72, 0.94}
    self.dispersionRate = 10
end

function Water:update(fieldClass, newField, dt)
    local isLowerBound = self.y == fieldClass.height

    if not isLowerBound then
        local isDownReachable = self.y < fieldClass.height and (fieldClass.field[self.y + 1][self.x] == 0 and newField[self.y + 1][self.x] == 0)
        if isDownReachable then
            for i=1,self.gravity do
                self.y = self.y + 1
                isDownReachable = self.y < fieldClass.height and (fieldClass.field[self.y + 1][self.x] == 0 and newField[self.y + 1][self.x] == 0)
                isLowerBound = self.y == fieldClass.height
                if (not isDownReachable) or isLowerBound then break end
            end
        else
            local isDownLeftReachable = self.x - 1 > 0 and (fieldClass.field[self.y + 1][self.x - 1] == 0 and newField[self.y + 1][self.x - 1] == 0)
            local isDownRightReachable = self.x + 1 <= fieldClass.width and (fieldClass.field[self.y + 1][self.x + 1] == 0 and newField[self.y + 1][self.x + 1] == 0)
            local isLeftReachable = self.x - 1 > 0 and (fieldClass.field[self.y][self.x - 1] == 0 and newField[self.y][self.x - 1] == 0)
            local isRightReachable = self.x + 1 <= fieldClass.width and (fieldClass.field[self.y][self.x + 1] == 0 and newField[self.y][self.x + 1] == 0)
            local sideChoice = -1

            if isDownLeftReachable and isDownRightReachable then sideChoice = love.math.random(0,1)
            elseif isDownLeftReachable then sideChoice = 0
            elseif isDownRightReachable then sideChoice = 1
            elseif isLeftReachable and isRightReachable then sideChoice = love.math.random(0,1)
            elseif isLeftReachable then sideChoice = 0
            elseif isRightReachable then sideChoice = 1
            end
            
            if sideChoice == 0 then
                for i=1,self.dispersionRate do
                    if isDownLeftReachable then
                        self.y = self.y + 1
                        self.x = self.x - 1
                    elseif isLeftReachable then
                        self.x = self.x - 1
                    end
                    isDownReachable = self.y < fieldClass.height and (fieldClass.field[self.y + 1][self.x] == 0 and newField[self.y + 1][self.x] == 0)
                    isDownLeftReachable = self.y < fieldClass.height and self.x - 1 > 0 and (fieldClass.field[self.y + 1][self.x - 1] == 0 and newField[self.y + 1][self.x - 1] == 0)
                    isLeftReachable = self.x - 1 > 0 and (fieldClass.field[self.y][self.x - 1] == 0 and newField[self.y][self.x - 1] == 0)
                    if isDownReachable or not (isDownLeftReachable or isLeftReachable) then
                        break
                    end
                end
            elseif sideChoice == 1 then
                for i=1,self.dispersionRate do
                    if isDownRightReachable then
                        self.y = self.y + 1
                        self.x = self.x + 1
                    elseif isRightReachable then
                        self.x = self.x + 1
                    end
                    isDownReachable = self.y < fieldClass.height and (fieldClass.field[self.y + 1][self.x] == 0 and newField[self.y + 1][self.x] == 0)
                    isDownRightReachable = self.y < fieldClass.height and self.x + 1 <= fieldClass.width and (fieldClass.field[self.y + 1][self.x + 1] == 0 and newField[self.y + 1][self.x + 1] == 0)
                    isRightReachable = self.x + 1 <= fieldClass.width and (fieldClass.field[self.y][self.x + 1] == 0 and newField[self.y][self.x + 1] == 0)
                    if isDownReachable or not (isDownRightReachable or isRightReachable) then
                        break
                    end
                end
            end
        end
    else
        local isLeftReachable = self.x - 1 > 0 and (fieldClass.field[self.y][self.x - 1] == 0 and newField[self.y][self.x - 1] == 0)
        local isRightReachable = self.x + 1 <= fieldClass.width and (fieldClass.field[self.y][self.x + 1] == 0 and newField[self.y][self.x + 1] == 0)
        if isLeftReachable then
            for i=1,self.dispersionRate do
                self.x = self.x - 1
                isLeftReachable = self.x - 1 > 0 and (fieldClass.field[self.y][self.x - 1] == 0 and newField[self.y][self.x - 1] == 0)
                if not isLeftReachable then break end
            end
        elseif isRightReachable then
            for i=1,self.dispersionRate do
                self.x = self.x + 1
                isRightReachable = self.x + 1 <= fieldClass.width and (fieldClass.field[self.y][self.x + 1] == 0 and newField[self.y][self.x + 1] == 0)
                if not isRightReachable then break end
            end
        end
    end
    newField[self.y][self.x] = self
end