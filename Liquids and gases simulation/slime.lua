Slime = Liquid:extend()

function Slime:new(x, y)
    Slime.super.new(self, x, y)
    self.color = {0.25, 0.75, 0.25, 0.5}
    self.dispersionRate = field.width / 50
    self.density = 800
    self.thermalConductivity = 5
end

function Slime:copy()
    local elem = Slime(self.x, self.y)
    elem.temp = self.temp
    elem.color = self.color
    return elem
end