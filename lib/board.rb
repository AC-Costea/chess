require 'pry'

require_relative './pieces/pawn.rb'
require_relative './pieces/rook.rb'
require_relative './pieces/knight.rb'
require_relative './pieces/bishop.rb'
require_relative './pieces/queen.rb'
require_relative './pieces/king.rb'
require_relative 'piece_movement.rb'

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
    attr_accessor :cell_row, :board, :player1, :player2, :white_pieces, :black_pieces
    def initialize
        @board = []
        @player1 = 'white'
        @player2 = 'black'
        @white_pieces = []
        @black_pieces = []
    end

    include Piece_movement
   
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

    def turn(color, n)
        show_board()
        puts "It's #{color}'s turn"
        loop do 
            break if move_piece(color, n + 1)
        end
    end

    def play
        create_board()
        set_pieces()
        n1 = 0
        n2 = 0
        (1..50).each do |n|
            n1 = n * 2 - 1
            n2 = n * 2
            turn('white', n1)
            turn('black', n2)
        end
    end
end

#game = Board.new
#game.play

