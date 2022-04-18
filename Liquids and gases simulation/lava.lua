Lava = Liquid:extend()

function Lava:new(x, y)
    Lava.super.new(self, x, y)
    self.color = {0.9, 0.4, 0.0, 0.65}
    self.dispersionRate = field.width / 100 + 1
    self.density = 1100
    self.thermalConductivity = 2.5
    self.tempBounds = {lower = {700, SolidStone}}
end

function Lava:colorChangeDueTemp(fieldClass)
    self.color[4] = 0.65 - fieldClass.insideTemp/100 + self.temp/100
    if self.color[4] < 0.3 then
        self.color[4] = 0.3
    end
end