Water = Liquid:extend()

function Water:new(x, y)
    Water.super.new(self, x, y)
    self.color = {0, 0.72, 0.94, 0.5}
    self.dispersionRate = field.width / 10
    self.density = 900
    self.thermalConductivity = 2.5
    self.tempBounds = {lower = {0, Ice}, upper = {100, Steam}}
end

function Water:copy()
    local elem = Water(self.x, self.y)
    elem.temp = self.temp
    elem.color = self.color
    return elem
end