Smoke2 = Gas:extend()

function Smoke2:new(x, y)
    Smoke2.super.new(self, x, y)
    self.color = {0.5, 0.5, 0.5}
    self.dispersionRate = field.width / 10
    self.density = 10
end

function Smoke2:copy()
    return Smoke2(self.x, self.y)
end