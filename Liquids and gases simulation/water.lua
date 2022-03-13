Water = Element:extend()

function Water:new(x, y)
    Water.super.new(self, x, y)
    self.color = {0, 0.72, 0.94}
    self.dispersionRate = 25
end

function Water:update(fieldClass, newField, dt)

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
            else
                isLeftReachable = self.x - 1 > 0 and 
                (fieldClass.field[self.y][self.x - 1] == 0 and newField[self.y][self.x - 1] == 0)
                isRightReachable = self.x + 1 <= fieldClass.width and 
                (fieldClass.field[self.y][self.x + 1] == 0 and newField[self.y][self.x + 1] == 0)
                if isLeftReachable and isRightReachable then
                    local choice = love.math.random(0,1)
                    for i=1,self.dispersionRate do
                        if choice == 0 then
                            self.x = self.x - 1
                            isLeftReachable = self.x - 1 > 0 and 
                            (fieldClass.field[self.y][self.x - 1] == 0 and newField[self.y][self.x - 1] == 0)
                            if not isLeftReachable then
                                break
                            end
                        else
                            self.x = self.x + 1
                            isRightReachable = self.x + 1 <= fieldClass.width and 
                            (fieldClass.field[self.y][self.x + 1] == 0 and newField[self.y][self.x + 1] == 0)
                            isDownRightReachable = self.x + 1 <= fieldClass.width and 
                            (fieldClass.field[self.y + 1][self.x + 1] == 0 and newField[self.y + 1][self.x + 1] == 0)
                            if not isRightReachable then
                                break
                            end
                        end 
                        if fieldClass.field[self.y + 1][self.x] == 0 and newField[self.y + 1][self.x] == 0 then
                            break
                        end
                    end
                elseif isLeftReachable then
                    for i=1,self.dispersionRate do
                        self.x = self.x - 1
                        isLeftReachable = self.x - 1 > 0 and 
                        (fieldClass.field[self.y][self.x - 1] == 0 and newField[self.y][self.x - 1] == 0)
                        if not isLeftReachable then
                            break
                        end
                    end
                elseif isRightReachable then
                    for i=1,self.dispersionRate do
                        self.x = self.x + 1
                        isRightReachable = self.x + 1 <= fieldClass.width and 
                        (fieldClass.field[self.y][self.x + 1] == 0 and newField[self.y][self.x + 1] == 0)
                        if not isRightReachable then
                            break
                        end
                    end
                end
            end
        end
    else
        isLeftReachable = self.x - 1 > 0 and 
        (fieldClass.field[self.y][self.x - 1] == 0 and newField[self.y][self.x - 1] == 0)
        isRightReachable = self.x + 1 <= fieldClass.width and 
        (fieldClass.field[self.y][self.x + 1] == 0 and newField[self.y][self.x + 1] == 0)
        if isLeftReachable and isRightReachable then
            local choice = love.math.random(0,1)
            for i=1,self.dispersionRate do
                if choice == 0 then
                    self.x = self.x - 1
                    isLeftReachable = self.x - 1 > 0 and 
                    (fieldClass.field[self.y][self.x - 1] == 0 and newField[self.y][self.x - 1] == 0)
                    if not isLeftReachable then
                        break
                    end
                else
                    self.x = self.x + 1
                    isRightReachable = self.x + 1 <= fieldClass.width and 
                    (fieldClass.field[self.y][self.x + 1] == 0 and newField[self.y][self.x + 1] == 0)
                    if not isRightReachable then
                        break
                    end
                end
            end
        elseif isLeftReachable then
            for i=1,self.dispersionRate do
                self.x = self.x - 1
                isLeftReachable = self.x - 1 > 0 and 
                (fieldClass.field[self.y][self.x - 1] == 0 and newField[self.y][self.x - 1] == 0)
                if not isLeftReachable then
                    break
                end
            end
        elseif isRightReachable then
            for i=1,self.dispersionRate do
                self.x = self.x + 1
                isRightReachable = self.x + 1 <= fieldClass.width and 
                (fieldClass.field[self.y][self.x + 1] == 0 and newField[self.y][self.x + 1] == 0)
                if not isRightReachable then
                    break
                end
            end
        end
    end
    newField[self.y][self.x] = self
end