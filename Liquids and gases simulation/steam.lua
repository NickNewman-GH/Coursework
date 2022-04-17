Steam = Gas:extend()

function Steam:new(x, y)
    Steam.super.new(self, x, y)
    self.color = {0.8, 0.8, 0.8, 0.65}
    self.dispersionRate = field.width / 10
    self.density = 10
    self.tempBounds = {lower = {75, Water}}
    self.thermalConductivity = 2
end

function Steam:colorChangeDueTemp(fieldClass)
    self.color[4] = 0.65 - fieldClass.insideTemp/250 + self.temp/250
    if self.color[4] < 0.3 then
        self.color[4] = 0.3
    end
end