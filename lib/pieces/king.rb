class King
    attr_accessor :color, :moveset
    def initialize(color)
        @color = color
        @moveset = [[1, 1], [-1, 1], [-1, -1], [1, -1], [1, 0], [-1, 0], [0, 1], [0, -1]]
    end
end