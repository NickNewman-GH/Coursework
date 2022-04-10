Element = Object:extend()

function Element:new(x, y)
    self.x = x
    self.y = y
    self.color = {1, 1, 1}
    self.gravity = field.height/50 + 1
    self.isUpdated = false
    self.density = 999999
    self.temp = 25
    self.thermalConductivity = 250
end

function Element:update(fieldClass, newField, dt)
    return
end

function Element:copy()
    return
end

function Element:giveTempToOthers(fieldClass, dt)
    local isOnObjectBorder = false
    for i=-1,1 do
        if self.y+i <= fieldClass.height and self.y+i > 0 then
            for j=-1,1 do
                if fieldClass.field[self.y+i][self.x+j] == 0 then
                    isOnObjectBorder = true
                end
                if self.x+j <= fieldClass.width and self.x+j > 0 and not (fieldClass.field[self.y+i][self.x+j] == 0) then
                    if not (i == 0 and (j == 0)) then
                        fieldClass.field[self.y+i][self.x+j].temp = fieldClass.field[self.y+i][self.x+j].temp + (self.temp - fieldClass.field[self.y+i][self.x+j].temp)/fieldClass.field[self.y+i][self.x+j].thermalConductivity * dt
                    end
                end
            end
        end
    end
    if isOnObjectBorder then
        self.temp = self.temp - (self.temp - fieldClass.insideTemp)/self.thermalConductivity * dt
    end
end