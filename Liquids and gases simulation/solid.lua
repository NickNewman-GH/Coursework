Solid = Element:extend()

function Solid:new(x, y)
    Solid.super.new(self, x, y)
end

function Solid:update(fieldClass, updateType, dt)
    if updateType == fieldClass.elementManager.updateTypes.MOVE then
        fieldClass.field[self.y][self.x] = 0
        local isDownReachable = fieldClass.field[self.y + 1][self.x] == 0
        local isDownLeftReachable = fieldClass.field[self.y + 1][self.x - 1] == 0
        local isDownRightReachable = fieldClass.field[self.y + 1][self.x + 1] == 0 
        if isDownReachable then
            for i=1,self.gravity do
                self.y = self.y + 1
                local isLowerBound = self.y == fieldClass.height
                isDownReachable = not isLowerBound and fieldClass.field[self.y + 1][self.x] == 0
                if not isDownReachable then
                    break
                end
            end
        else
            if isDownLeftReachable and isDownRightReachable then
                self.y = self.y + 1
                local sideChoice = love.math.random(0,1)
                if sideChoice == 0 then self.x = self.x - 1
                else self.x = self.x + 1 end
            elseif isDownLeftReachable then
                self.y = self.y + 1
                self.x = self.x - 1
            elseif isDownRightReachable then
                self.y = self.y + 1
                self.x = self.x + 1
            end
        end
    elseif updateType == fieldClass.elementManager.updateTypes.SWAP then
        local targetCell = fieldClass.field[self.y + 1][self.x]
        local isDownCanBeSwapped = not (targetCell == 0) and not targetCell.isUpdated and targetCell.density and targetCell.density < self.density
        if isDownCanBeSwapped then
            targetCell.y = targetCell.y - 1
            fieldClass.field[self.y][self.x] = targetCell
            fieldClass.field[self.y][self.x].isUpdated = true
            self.y = self.y + 1
        else
            local targetCellLeft = fieldClass.field[self.y + 1][self.x - 1]
            local isDownLeftCanBeSwapped = not (targetCellLeft == 0) and not (targetCellLeft == nil) and not targetCellLeft.isUpdated and targetCellLeft.density and targetCellLeft.density < self.density
            local targetCellRight = fieldClass.field[self.y + 1][self.x + 1]
            local isDownRightCanBeSwapped = not (targetCellRight == 0) and not (targetCellRight == nil) and not targetCellRight.isUpdated and targetCellRight.density and targetCellRight.density < self.density
            if isDownLeftCanBeSwapped and isDownRightCanBeSwapped then
                local y = self.y + 1
                local x = nil
                if love.math.random(0,1) == 0 then x = self.x - 1
                else x = self.x + 1 end
                local chosedCell = fieldClass.field[y][x]
                chosedCell.y = chosedCell.y - 1
                chosedCell.x = chosedCell.x + (self.x - x)
                fieldClass.field[self.y][self.x] = chosedCell
                fieldClass.field[self.y][self.x].isUpdated = true
                self.y, self.x = y, x
            elseif isDownLeftCanBeSwapped then
                local y = self.y + 1
                local x = self.x - 1
                targetCellLeft.y = targetCellLeft.y - 1
                targetCellLeft.x = targetCellLeft.x + 1
                fieldClass.field[self.y][self.x] = targetCellLeft
                fieldClass.field[self.y][self.x].isUpdated = true
                self.y, self.x = y, x
            elseif isDownRightCanBeSwapped then
                local y = self.y + 1
                local x = self.x + 1
                targetCellRight.y = targetCellRight.y - 1
                targetCellRight.x = targetCellRight.x - 1
                fieldClass.field[self.y][self.x] = targetCellRight
                fieldClass.field[self.y][self.x].isUpdated = true
                self.y, self.x = y, x
            end
        end
    elseif updateType == fieldClass.elementManager.updateTypes.REPLACE then
        if self.tempBounds["lower"] and self.temp < self.tempBounds["lower"][1] then
            fieldClass.field[self.y][self.x] = self.tempBounds["lower"][2](self.x, self.y)
            fieldClass.field[self.y][self.x].temp = self.temp
            self.isUpdated = true
        elseif self.tempBounds["upper"] and self.temp > self.tempBounds["upper"][1] then
            fieldClass.field[self.y][self.x] = self.tempBounds["upper"][2](self.x, self.y)
            fieldClass.field[self.y][self.x].temp = self.temp
            self.isUpdated = true
        end
        fieldClass.field[self.y][self.x]:colorChangeDueTemp(fieldClass)
        return
    end
    self:colorChangeDueTemp(fieldClass)
    fieldClass.field[self.y][self.x] = self
    self.isUpdated = true
end

function Solid:getUpdateType(fieldClass)
    if self.tempBounds then
        if self.tempBounds["lower"] and self.temp < self.tempBounds["lower"][1] then
            return fieldClass.elementManager.updateTypes.REPLACE
        elseif self.tempBounds["upper"] and self.temp > self.tempBounds["upper"][1] then
            return fieldClass.elementManager.updateTypes.REPLACE
        end
    end
    local isLowerBound = self.y == fieldClass.height
    if isLowerBound then
        return fieldClass.elementManager.updateTypes.NONE
    else
        local targetCell = fieldClass.field[self.y + 1][self.x]
        local isDownReachable = targetCell == 0
        local isDownLowerDensity = not isDownReachable and targetCell.density and targetCell.density < self.density
        if isDownReachable then
            return fieldClass.elementManager.updateTypes.MOVE
        elseif isDownLowerDensity then
            return fieldClass.elementManager.updateTypes.SWAP
        else
            local downLeftTargetCell = fieldClass.field[self.y + 1][self.x - 1]
            local isDownLeftReachable = downLeftTargetCell == 0
            
            local downRightTargetCell = fieldClass.field[self.y + 1][self.x + 1]
            local isDownRightReachable = downRightTargetCell == 0

            if isDownLeftReachable or isDownRightReachable then
                return fieldClass.elementManager.updateTypes.MOVE
            else
                local isDownLeftLowerDensity = not ((downLeftTargetCell == 0) or (downLeftTargetCell == nil)) and downLeftTargetCell.density and downLeftTargetCell.density < self.density
                local isDownRightLowerDensity = not ((downRightTargetCell == 0) or (downRightTargetCell == nil)) and downRightTargetCell.density and downRightTargetCell.density < self.density
                if isDownLeftLowerDensity or isDownRightLowerDensity then
                    return fieldClass.elementManager.updateTypes.SWAP
                end
            end
            return fieldClass.elementManager.updateTypes.NONE
        end
    end
end