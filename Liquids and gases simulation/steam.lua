Steam = Gas:extend()

function Steam:new(x, y)
    Steam.super.new(self, x, y)
    self.color = {0.8, 0.8, 0.8, 0.5}
    self.dispersionRate = field.width / 10
    self.density = 15
    self.tempBounds = {lower = {75, Water}}
    self.thermalConductivity = 2
end

function Steam:copy()
    local elem = Steam(self.x, self.y)
    elem.temp = self.temp
    elem.color = self.color
    return elem
end