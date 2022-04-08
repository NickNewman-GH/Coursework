Liquid = Element:extend()

function Liquid:new(x, y)
    Liquid.super.new(self, x, y)
    self.dispersionRate = 0
    self.density = 0
end

function Liquid:update(fieldClass, newField, updateType, dt)
    if updateType == fieldClass.elementManager.updateTypes.MOVE then
        local isLowerBound = self.y == fieldClass.height
        if not isLowerBound then
            local isDownReachable = not isLowerBound and (fieldClass.field[self.y + 1][self.x] == 0 and newField[self.y + 1][self.x] == 0)
            local isDownLeftReachable = not isLowerBound and self.x - 1 > 0 and (fieldClass.field[self.y + 1][self.x - 1] == 0 and newField[self.y + 1][self.x - 1] == 0)
            local isDownRightReachable = not isLowerBound and self.x + 1 <= fieldClass.width and (fieldClass.field[self.y + 1][self.x + 1] == 0 and newField[self.y + 1][self.x + 1] == 0)
            if isDownReachable or isDownRightReachable or isDownLeftReachable then
                local gravRand = 0
                if self.gravity >= 5 then
                    gravRand = love.math.random(-1,1)
                end
                for i=1,(self.gravity - gravRand) do
                    if isDownReachable and love.math.random(100) > 5 then
                        self.y = self.y + 1
                        -- if not isDownReachable then break end
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
                        else
                            break
                        end
                    end
                    isLowerBound = self.y == fieldClass.height
                    isDownReachable = not isLowerBound and (fieldClass.field[self.y + 1][self.x] == 0 and newField[self.y + 1][self.x] == 0)
                    isDownLeftReachable = not isLowerBound and self.x - 1 > 0 and (fieldClass.field[self.y + 1][self.x - 1] == 0 and newField[self.y + 1][self.x - 1] == 0)
                    isDownRightReachable = not isLowerBound and self.x + 1 <= fieldClass.width and (fieldClass.field[self.y + 1][self.x + 1] == 0 and newField[self.y + 1][self.x + 1] == 0)
                    if isLowerBound then break end
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
                    local energy = self.dispersionRate
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
                        if not (isDownLeftReachable or isLeftReachable) then
                            break
                        end
                        energy = energy - 1
                        if isDownReachable then
                            energy = energy - self.dispersionRate/3
                        end
                        if energy < 1 then
                            break
                        end
                    end
                elseif sideChoice == 1 then
                    local energy = self.dispersionRate
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
                        if not (isDownRightReachable or isRightReachable) then
                            break
                        end
                        energy = energy - 1
                        if isDownReachable then
                            energy = energy - self.dispersionRate/3
                        end
                        if energy < 1 then
                            break
                        end
                    end
                end
            end
        else
            local isLeftReachable = self.x - 1 > 0 and (fieldClass.field[self.y][self.x - 1] == 0 and newField[self.y][self.x - 1] == 0)
            local isRightReachable = self.x + 1 <= fieldClass.width and (fieldClass.field[self.y][self.x + 1] == 0 and newField[self.y][self.x + 1] == 0)
            if isLeftReachable and isRightReachable then
                local sideChoice = love.math.random(0,1)
                if sideChoice == 0 then self.x = self.x - 1
                else self.x = self.x + 1 end
            elseif isLeftReachable then
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
    elseif updateType == fieldClass.elementManager.updateTypes.SWAP then
        local isLowerBound = self.y == fieldClass.height
        local targetCellDown = nil
        if not isLowerBound then
            targetCellDown = fieldClass.field[self.y + 1][self.x]
        end
        local isDownCanBeSwapped = not (targetCellDown == 0) and not (targetCellDown == nil) and not targetCellDown.isUpdated and targetCellDown.density < self.density
        if isDownCanBeSwapped then
            targetCellDown.y = targetCellDown.y - 1
            newField[self.y][self.x] = targetCellDown:copy()
            fieldClass.field[self.y + 1][self.x].isUpdated = true
            self.y = self.y + 1
        else
            local targetCellLeft, targetCellRight = nil, nil
            if not isLowerBound then
                targetCellLeft = fieldClass.field[self.y + 1][self.x - 1]
                targetCellRight = fieldClass.field[self.y + 1][self.x + 1]
            end
            local isDownLeftCanBeSwapped = not (targetCellLeft == 0) and not (targetCellLeft == nil) and not targetCellLeft.isUpdated and targetCellLeft.density < self.density
            local isDownRightCanBeSwapped = not (targetCellRight == 0) and not (targetCellRight == nil) and not targetCellRight.isUpdated and targetCellRight.density < self.density
            if isDownLeftCanBeSwapped and isDownRightCanBeSwapped then
                local y = self.y + 1
                local x = nil
                if love.math.random(0,1) == 0 then x = self.x - 1
                else x = self.x + 1 end
                local chosedCell = fieldClass.field[y][x]
                chosedCell.y = chosedCell.y - 1
                chosedCell.x = chosedCell.x + (self.x - x)
                newField[self.y][self.x] = chosedCell:copy()
                fieldClass.field[y][x].isUpdated = true
                self.y, self.x = y, x
            elseif isDownLeftCanBeSwapped then
                local y = self.y + 1
                local x = self.x - 1
                targetCellLeft.y = targetCellLeft.y - 1
                targetCellLeft.x = targetCellLeft.x + 1
                newField[self.y][self.x] = targetCellLeft:copy()
                fieldClass.field[y][x].isUpdated = true
                self.y, self.x = y, x
            elseif isDownRightCanBeSwapped then
                local y = self.y + 1
                local x = self.x + 1
                targetCellRight.y = targetCellRight.y - 1
                targetCellRight.x = targetCellRight.x - 1
                newField[self.y][self.x] = targetCellRight:copy()
                fieldClass.field[y][x].isUpdated = true
                self.y, self.x = y, x
            else
                targetCellLeft = fieldClass.field[self.y][self.x - 1]
                local isLeftCanBeSwapped = not (targetCellLeft == 0) and not (targetCellLeft == nil) and not targetCellLeft.isUpdated and targetCellLeft.density <= self.density
                targetCellRight = fieldClass.field[self.y][self.x + 1]
                local isRightCanBeSwapped = not (targetCellRight == 0) and not (targetCellRight == nil) and not targetCellRight.isUpdated and targetCellRight.density <= self.density
                if isLeftCanBeSwapped and isRightCanBeSwapped then
                    local x = nil
                    if love.math.random(0,1) == 0 then x = self.x - 1
                    else x = self.x + 1 end
                    local chosedCell = fieldClass.field[self.y][x]
                    chosedCell.x = chosedCell.x + (self.x - x)
                    newField[self.y][self.x] = chosedCell:copy()
                    fieldClass.field[self.y][x].isUpdated = true
                    self.x = x
                elseif isLeftCanBeSwapped then
                    targetCellLeft.x = targetCellLeft.x + 1
                    newField[self.y][self.x] = targetCellLeft:copy()
                    fieldClass.field[self.y][self.x - 1].isUpdated = true
                    self.x = self.x - 1
                elseif isRightCanBeSwapped then
                    targetCellRight.x = targetCellRight.x - 1
                    newField[self.y][self.x] = targetCellRight:copy()
                    fieldClass.field[self.y][self.x + 1].isUpdated = true
                    self.x = self.x + 1
                end
            end
        end
    end
    newField[self.y][self.x] = self:copy()
    self.isUpdated = true
end

function Liquid:getUpdateType(fieldClass)
    local isLowerBound = self.y == fieldClass.height
    if isLowerBound then
        leftTargetCell = fieldClass.field[self.y][self.x - 1]
        rightTargetCell = fieldClass.field[self.y][self.x + 1]
        local isLeftReachable = leftTargetCell == 0
        local isRightReachable = rightTargetCell == 0
        if isLeftReachable or isRightReachable then 
            return fieldClass.elementManager.updateTypes.MOVE
        else
            local isLeftLowerDensity = not ((leftTargetCell == 0) or (leftTargetCell == nil) or (rightTargetCell == nil)) and leftTargetCell.density <= self.density
            local isRightLowerDensity = not ((rightTargetCell == 0) or (rightTargetCell == nil) or (leftTargetCell == nil)) and rightTargetCell.density <= self.density
            if isLeftLowerDensity or isRightLowerDensity then
                return fieldClass.elementManager.updateTypes.SWAP
            end
        end
    else
        local targetCell = fieldClass.field[self.y + 1][self.x]
        local isDownReachable = targetCell == 0
        local isDownLowerDensity = not isDownReachable and targetCell.density < self.density
        if isDownReachable then
            return fieldClass.elementManager.updateTypes.MOVE
        elseif isDownLowerDensity then
            return fieldClass.elementManager.updateTypes.SWAP
        else
            local leftTargetCell = fieldClass.field[self.y + 1][self.x - 1]
            local isDownLeftReachable = leftTargetCell == 0
            
            local rightTargetCell = fieldClass.field[self.y + 1][self.x + 1]
            local isDownRightReachable = rightTargetCell == 0

            if isDownLeftReachable or isDownRightReachable then
                return fieldClass.elementManager.updateTypes.MOVE
            else
                local isDownLeftLowerDensity = not ((leftTargetCell == 0) or (leftTargetCell == nil)) and leftTargetCell.density < self.density
                local isDownRightLowerDensity = not ((rightTargetCell == 0) or (rightTargetCell == nil)) and rightTargetCell.density < self.density
                if isDownLeftLowerDensity or isDownRightLowerDensity then
                    return fieldClass.elementManager.updateTypes.SWAP
                else
                    leftTargetCell = fieldClass.field[self.y][self.x - 1]
                    rightTargetCell = fieldClass.field[self.y][self.x + 1]
                    local isLeftReachable = leftTargetCell == 0
                    local isRightReachable = rightTargetCell == 0
                    if isLeftReachable or isRightReachable then 
                        return fieldClass.elementManager.updateTypes.MOVE
                    else
                        local isLeftLowerDensity = not ((leftTargetCell == 0) or (leftTargetCell == nil) or (rightTargetCell == nil)) and leftTargetCell.density <= self.density
                        local isRightLowerDensity = not ((rightTargetCell == 0) or (rightTargetCell == nil) or (leftTargetCell == nil)) and rightTargetCell.density <= self.density
                        if isLeftLowerDensity or isRightLowerDensity then
                            return fieldClass.elementManager.updateTypes.SWAP
                        end
                    end
                end
            end
        end
    end
    return fieldClass.elementManager.updateTypes.NONE
end