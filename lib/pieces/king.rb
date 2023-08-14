class King
    attr_accessor :color, :moveset, :moves_made
    def initialize(color)
        @moves_made = 0
        @color = color
        @moveset = [[1, 1], [-1, 1], [-1, -1], [1, -1], [1, 0], [-1, 0], [0, 1], [0, -1]]
    end
end