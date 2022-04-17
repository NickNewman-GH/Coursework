Sand2 = Solid:extend()

function Sand2:new(x, y)
    Sand2.super.new(self, x, y)
    self.color = {0.55, 0.5, 0.75}
    self.density = 775
end