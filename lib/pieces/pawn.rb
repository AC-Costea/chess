class Pawn
    attr_accessor :color, :moveset_black, :moveset_white, :moveset_white_attack, :moveset_black_attack, :ranks_traveled
    def initialize(color)
        @color = color
        @moveset_white = [[0, 2], [0, 1]]
        @moveset_black = [[0, -2], [0, -1]]
        @moveset_white_attack = [[1, 1], [-1, 1]]
        @moveset_black_attack = [[1, -1], [-1, -1]]
        @ranks_traveled = 0
    end
end