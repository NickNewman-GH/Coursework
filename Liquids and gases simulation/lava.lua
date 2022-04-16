Lava = Liquid:extend()

function Lava:new(x, y)
    Lava.super.new(self, x, y)
    self.color = {0.9, 0.4, 0.0, 0.65}
    self.dispersionRate = field.width / 100
    self.density = 1100
    self.thermalConductivity = 2.5
    self.tempBounds = {lower = {700, SolidStone}}
end

function Lava:copy()
    local elem = Lava(self.x, self.y)
    elem.temp = self.temp
    elem.color = self.color
    return elem
end