class Pawn
    attr_accessor :color, :moveset
    def initialize(color)
        @color = color
        @moveset = [[0, 2], [0, 1]]
    end
end