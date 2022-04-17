Sand1 = Solid:extend()

function Sand1:new(x, y)
    Sand1.super.new(self, x, y)
    self.color = {0.25, 0.25, 0.75}
    self.density = 950
end