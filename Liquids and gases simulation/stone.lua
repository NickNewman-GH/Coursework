Stone = Static:extend()

function Stone:new(x, y)
    Stone.super.new(self, x, y)
    self.color = {0.5, 0.5, 0.5}
    self.thermalConductivity = 5
    self.tempBounds = {upper = {1000, Lava}}
end

function Stone:colorChangeDueTemp(fieldClass)
    local lowerBound = 0
    local upperBound = 100
    self.color[4] = 0.65 - fieldClass.insideTemp/1000 + self.temp/1000
    if self.color[4] < 0.3 then
        self.color[4] = 0.3
    end
    --self.color[4] = lerp(0.6,1,(self.temp - lowerBound)/(upperBound - lowerBound))
end