Stone = Static:extend()

function Stone:new(x, y)
    Stone.super.new(self, x, y)
    self.color = {0.5, 0.5, 0.5}
end

function Stone:copy()
    return Stone(self.x, self.y)
end