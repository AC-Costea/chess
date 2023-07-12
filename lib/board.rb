require 'pry'

require_relative './pieces/pawn.rb'
require_relative './pieces/rook.rb'
require_relative './pieces/knight.rb'
require_relative './pieces/bishop.rb'
require_relative './pieces/queen.rb'
require_relative './pieces/king.rb'

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

    def valid_input?(input)
        if input.length > 2 || input.length < 2
            return false
        else
            if ('a'..'h').include?(input[0]) && (1..8).include?(input[1].to_i)
                return true
            else
                return false
            end
        end
    end

    def input
        input = gets.chomp
        loop do
            break if valid_input?(input)
            puts 'You must introduce a letter, then a number'
            input = gets.chomp
        end
    end

    def letter_to_number(letter)
        @letters.fetch(letter)
    end

    def get_coordinates
        input = input()
        x = letter_to_number(input[0])
        y = input[1].to_i - 1
        return [x, y]
    end

    def select_piece
        coord = get_coordinates()
        loop do
            break if @board[7 - coord[1]][coord[0]].piece != nil
            puts 'Select a piece'
            coord = get_coordinates()
        end
        return @board[7 - coord[1]][coord[0]]
    end

    def select_destination
        coord = get_coordinates()
        return @board[7 - coord[1]][coord[0]]
    end

    

    def create_board
        (-7..0).each do |y|
            array = []
            (0..7).each do |x|
                array << Cell.new(x, y.abs)
            end
            @board << array
        end
    end

    def set_pieces
        for cell in @board[1]
            cell.value = ' ♙ '
            cell.piece = Pawn.new('black')
        end

        for cell in @board[6]
            cell.value = ' ♟︎ '
            cell.piece = Pawn.new('white')
        end

        @board[0][0].value = ' ♖ '
        @board[0][0].piece = Rook.new('black')
        @board[7][0].value = ' ♜ '
        @board[7][0].piece = Rook.new('white')
        @board[0][7].value = ' ♖ '
        @board[0][7].piece = Rook.new('black')
        @board[7][7].value = ' ♜ '
        @board[7][7].piece = Rook.new('white')

        @board[0][1].value = ' ♘ '
        @board[0][1].piece = Knight.new('black')
        @board[7][1].value = ' ♞ '
        @board[7][1].piece = Knight.new('white') 
        @board[0][6].value = ' ♘ '
        @board[0][6].piece = Knight.new('black')
        @board[7][6].value = ' ♞ '
        @board[7][6].piece = Knight.new('white')

        @board[0][2].value = ' ♗ '
        @board[0][2].piece = Bishop.new('black')
        @board[7][2].value = ' ♝ '
        @board[7][2].piece = Bishop.new('white')
        @board[0][5].value = ' ♗ '
        @board[0][5].piece = Bishop.new('black')
        @board[7][5].value = ' ♝ '
        @board[7][5].piece = Bishop.new('white')

        @board[0][3].value = ' ♕ '
        @board[0][3].piece = Queen.new('black')
        @board[7][3].value = ' ♛ '
        @board[7][3].piece = Queen.new('white')

        @board[0][4].value = ' ♔ '
        @board[0][4].piece = King.new('black')
        @board[7][4].value = ' ♚ '
        @board[7][4].piece = King.new('white')
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