class Knight
    attr_accessor :color, :moveset
    def initialize(color)
        @color = color
        @moveset = [[2, 1], [1, 2], [-1, 2], [-2, 1], [-2, -1], [-1, -2], [1, -2], [2, -1]]
    end
end