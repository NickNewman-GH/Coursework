Stone = Static:extend()

function Stone:new(x, y)
    Stone.super.new(self, x, y)
    self.color = {0.5, 0.5, 0.5, 0.65}
    self.thermalConductivity = 5
    self.tempBounds = {upper = {1000, Lava}}
end

function Stone:colorChangeDueTemp(fieldClass)
    self.color[4] = 0.65 - fieldClass.insideTemp/500 + self.temp/500
    if self.color[4] < 0.3 then
        self.color[4] = 0.3
    end
end