require 'pry'

require_relative './pieces/pawn.rb'
require_relative './pieces/rook.rb'
require_relative './pieces/knight.rb'
require_relative './pieces/bishop.rb'
require_relative './pieces/queen.rb'
require_relative './pieces/king.rb'
require_relative 'piece_movement.rb'
require_relative 'piece_exceptions.rb'

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
    attr_accessor :cell_row, :board, :player1, :player2
    def initialize
        @board = []
        @player1 = 'white'
        @player2 = 'black'
    end

    include Piece_movement
    include Piece_exceptions

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
        puts '   a  b  c  d  e  f  g  h'
        for row in @board
            array = []
            for cell in row
                array << cell.value
            end
            puts "#{8 - @board.index(row)} " + array.join + " #{8 - @board.index(row)}"
        end
        puts '   a  b  c  d  e  f  g  h'
    end

    def round
        show_board()
        puts "It's white's turn"
        loop do
            break if move_piece('white')
        end
        show_board()
        puts "It's black's turn"
        loop do
            break if move_piece('black')
        end
    end
end
