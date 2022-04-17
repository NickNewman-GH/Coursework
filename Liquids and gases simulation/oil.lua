Oil = Liquid:extend()

function Oil:new(x, y)
    Oil.super.new(self, x, y)
    self.color = {1, 0.9, 0, 0.65}
    self.dispersionRate = field.width / 15
    self.density = 900
    self.thermalConductivity = 2
end

function Oil:colorChangeDueTemp(fieldClass)
    self.color[4] = 0.65 - fieldClass.insideTemp/100 + self.temp/100
    if self.color[4] < 0.3 then
        self.color[4] = 0.3
    end
end