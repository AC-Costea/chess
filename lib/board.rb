require 'pry'

class Cell
    attr_accessor :x, :y, :value, :piece
    def initialize(x, y, value = ' - ', piece = nil)
        @x = x
        @y = y
        @value = value
        @piece = piece
    end
end

class Board
    attr_accessor :cell_row, :board
    def initialize
        @board = []
        @letters = {'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4, 'f' => 5, 'g' => 6, 'h' => 7}
    end

    def letter_to_number(letter)
        @letters.fetch(letter)
    end

    def create_board
        (-7..0).each do |number|
            array = []
            ('a'..'h').each do |letter|
                array << Cell.new(letter, number.abs)
            end
            @board << array
        end
    end

    def set_pieces
        for cell in @board[1]
            cell.value = ' ♙ '
        end

        for cell in @board[6]
            cell.value = ' ♟︎ '
        end

        @board[0][0].value = ' ♖ '
        @board[7][0].value = ' ♜ '
        @board[0][7].value = ' ♖ '
        @board[7][7].value = ' ♜ '

        @board[0][1].value = ' ♘ '
        @board[7][1].value = ' ♞ ' 
        @board[0][6].value = ' ♘ '
        @board[7][6].value = ' ♞ '

        @board[0][2].value = ' ♗ '
        @board[7][2].value = ' ♝ '
        @board[0][5].value = ' ♗ '
        @board[7][5].value = ' ♝ '

        @board[0][3].value = ' ♕ '
        @board[7][3].value = ' ♛ '

        @board[0][4].value = ' ♔ '
        @board[7][4].value = ' ♚ '
    end

    def show_board
        for row in @board
            array = []
            for cell in row
                array << cell.value
            end
            puts "#{8 - @board.index(row)} " + array.join
        end
        puts '   a  b  c  d  e  f  g  h'
    end
end
=begin
game = Board.new
game.create_board
game.set_pieces
game.show_board
=end