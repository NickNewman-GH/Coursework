Water = Liquid:extend()

function Water:new(x, y)
    Water.super.new(self, x, y)
    self.color = {0.1, 0.6, 0.85}
    self.dispersionRate = field.width / 10 + 1
    self.density = 900
    self.thermalConductivity = 2.5
    self.tempBounds = {lower = {0, Ice}, upper = {100, Steam}}
end

function Water:colorChangeDueTemp(fieldClass)
    local lowerBound = 0
    local upperBound = 100
    self.color[4] = 0.65 - fieldClass.insideTemp/250 + self.temp/250
    if self.color[4] < 0.3 then
        self.color[4] = 0.3
    end
    --self.color[4] = lerp(0.5,1,(self.temp - lowerBound)/(upperBound - lowerBound))
end