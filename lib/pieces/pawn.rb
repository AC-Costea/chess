class Pawn
    attr_accessor :color, :moveset_black, :moveset_white
    def initialize(color)
        @color = color
        @moveset_white = [[0, 2], [0, 1]]
        @moveset_black = [[0, -2], [0, -1]]
        @moveset_white_attack = [[1, 1], [-1, 1]]
        @moveset_black_attack = [[1, -1], [-1, -1]]
    end
end