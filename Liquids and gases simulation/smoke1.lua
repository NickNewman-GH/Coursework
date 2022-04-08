Smoke1 = Gas:extend()

function Smoke1:new(x, y)
    Smoke1.super.new(self, x, y)
    self.color = {0.4, 0.4, 0.4}
    self.dispersionRate = field.width / 10
    self.density = 10
end

function Smoke1:copy()
    return Smoke1(self.x, self.y)
end