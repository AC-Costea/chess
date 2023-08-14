class Rook
    attr_accessor :color, :moveset, :moves_made
    def initialize(color)
        @moves_made = 0
        @color = color
        @moveset = [
        [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0],
        [-1 , 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0],
        [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
        [0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7]
        ]
    end
end