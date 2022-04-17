Water = Liquid:extend()

function Water:new(x, y)
    Water.super.new(self, x, y)
    self.color = {0, 0.5, 0.7}
    self.dispersionRate = field.width / 10
    self.density = 900
    self.thermalConductivity = 2.5
    self.tempBounds = {lower = {0, Ice}, upper = {100, Steam}}
    self:colorChangeDueTemp()
end

function Water:colorChangeDueTemp(fieldClass)
    local lowerBound = 0
    local upperBound = 100
    self.color[4] = lerp(0.5,1,(self.temp - lowerBound)/(upperBound - lowerBound))
    self.color[2] = lerp(0.4,0.6,(self.temp - lowerBound)/(upperBound - lowerBound))
    self.color[3] = lerp(0.5,0.8,(self.temp - lowerBound)/(upperBound - lowerBound))
end