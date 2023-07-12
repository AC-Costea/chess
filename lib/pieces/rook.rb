class Rook
    attr_accessor :color, :moveset
    def initialize(color)
        @color = color
        @moves = [
        [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0],
        [-1 , 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0],
        [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
        [0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7]
        ]
    end
end