Slime = Liquid:extend()

function Slime:new(x, y)
    Slime.super.new(self, x, y)
    self.color = {0.25, 0.75, 0.25, 0.65}
    self.dispersionRate = field.width / 50
    self.density = 800
    self.thermalConductivity = 5
end

function Slime:colorChangeDueTemp(fieldClass)
    self.color[4] = 0.65 - fieldClass.insideTemp/100 + self.temp/100
    if self.color[4] < 0.3 then
        self.color[4] = 0.3
    end
end