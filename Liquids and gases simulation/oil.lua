Oil = Liquid:extend()

function Oil:new(x, y)
    Oil.super.new(self, x, y)
    self.color = {1, 0.9, 0, 0.65}
    self.dispersionRate = field.width / 20 + 1
    self.density = 900
    self.thermalConductivity = 2
end

function Oil:colorChangeDueTemp(fieldClass)
    local lowerBound = 0
    local upperBound = 100
    self.color[4] = 0.65 - fieldClass.insideTemp/250 + self.temp/250
    if self.color[4] < 0.3 then
        self.color[4] = 0.3
    end
    --self.color[4] = lerp(0.6,1,(self.temp - lowerBound)/(upperBound - lowerBound))
end