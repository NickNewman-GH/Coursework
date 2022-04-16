Stone = Static:extend()

function Stone:new(x, y)
    Stone.super.new(self, x, y)
    self.color = {0.5, 0.5, 0.5, 0.65}
    self.thermalConductivity = 5
    self.tempBounds = {upper = {1000, Lava}}
end

function Stone:copy()
    local elem = Stone(self.x, self.y)
    elem.temp = self.temp
    elem.color = self.color
    return elem
end