Oil = Liquid:extend()

function Oil:new(x, y)
    Oil.super.new(self, x, y)
    self.color = {1, 0.9, 0}
    self.dispersionRate = field.width / 15
    self.density = 750
end

function Oil:copy()
    return Oil(self.x, self.y)
end