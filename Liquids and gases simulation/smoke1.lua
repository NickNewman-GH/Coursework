Smoke1 = Gas:extend()

function Smoke1:new(x, y)
    Smoke1.super.new(self, x, y)
    self.color = {0.4, 0.4, 0.4, 0.65}
    self.dispersionRate = field.width / 10
    self.density = 10
end