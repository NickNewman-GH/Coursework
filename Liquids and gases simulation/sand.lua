Sand = Element:extend()

function Sand:new(x, y)
    Sand.super.new(self, x, y)
    self.color = {0.82, 0.65, 0}
    self.density = 1500
end

function Sand:update(fieldClass, newField, dt)
    if not self.isUpdated then
        local isLowerBound = self.y == fieldClass.height
        if not isLowerBound then
            local targetCell = fieldClass.field[self.y + 1][self.x]
            local isDownReachable = targetCell == 0 and newField[self.y + 1][self.x] == 0
            local isDownLeftReachable = self.x - 1 > 0 and (fieldClass.field[self.y + 1][self.x - 1] == 0 and newField[self.y + 1][self.x - 1] == 0)
            local isDownRightReachable = self.x + 1 <= fieldClass.width and (fieldClass.field[self.y + 1][self.x + 1] == 0 and newField[self.y + 1][self.x + 1] == 0)
            if isDownReachable then
                for i=1,self.gravity do
                    self.y = self.y + 1
                    isLowerBound = self.y == fieldClass.height
                    isDownReachable = not isLowerBound and (fieldClass.field[self.y + 1][self.x] == 0 and newField[self.y + 1][self.x] == 0)
                    if (not isDownReachable) or isLowerBound then
                        break
                    end
                end
            elseif isDownLeftReachable or isDownRightReachable then
                if isDownLeftReachable and isDownRightReachable then
                    self.y = self.y + 1
                    local coordChange = {-1, 1}
                    self.x = self.x + coordChange[love.math.random(1,2)]
                elseif isDownLeftReachable then
                    self.y = self.y + 1
                    self.x = self.x - 1
                elseif isDownRightReachable then
                    self.y = self.y + 1
                    self.x = self.x + 1
                end
            elseif not (targetCell == 0) and (newField[self.y + 1][self.x] == 0) and newField[self.y][self.x] == 0 and fieldClass.field[self.y + 1][self.x].density < self.density then
                newField[self.y][self.x] = fieldClass.field[self.y + 1][self.x]:copy()
                fieldClass.field[self.y + 1][self.x].isUpdated = true
                self.y = self.y + 1
            end
        end
        --if newField[self.y][self.x] == 0 then
        newField[self.y][self.x] = self:copy()
        --end
        self.isUpdated = true
    else
        self.isUpdated = false
    end
end

function Sand:copy()
    return Sand(self.x, self.y)
end