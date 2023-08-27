require 'pry'
require 'json'
require_relative './pieces/pawn.rb'
require_relative './pieces/rook.rb'
require_relative './pieces/knight.rb'
require_relative './pieces/bishop.rb'
require_relative './pieces/queen.rb'
require_relative './pieces/king.rb'
require_relative 'piece_movement.rb'
require_relative 'check_mate.rb'

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
        @list_of_values = []
    end
    include Checkmate
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
        return 2 if is_stalemate?(color)
        return 1 if is_checkmate?(color)
        puts "It's #{color}'s turn"
        loop do 
            break if move_piece(color, n + 1)
        end
    end

    def play
        create_board()
        set_pieces()

        if File.exist?('/mnt/c/Users/const/downloads/repos/chess/data.json')
            puts "If you want to load previous save data, write '1', else write '0'"
            input = gets.chomp
            until input == '1' || input == '0'
                puts 'Write either 1 or 0'
                input = gets.chomp
            end
            if input == '1'
                use_save_data()
                n = -1
                for cell in @board.flatten
                    cell.value = @list_of_values[n + 1]
                    n += 1
                end
                for cell in @board.flatten
                    cell.piece = nil if cell.value == ' - '
                    cell.piece = Pawn.new('white') if cell.value == ' ♟︎ '
                    cell.piece = Pawn.new('black') if cell.value == ' ♙ '
                    cell.piece = Rook.new('white') if cell.value == ' ♜ '
                    cell.piece = Rook.new('black') if cell.value == ' ♖ '
                    cell.piece = Knight.new('white') if cell.value == ' ♞ '
                    cell.piece = Knight.new('black') if cell.value == ' ♘ '
                    cell.piece = Bishop.new('white') if cell.value == ' ♝ '
                    cell.piece = Knight.new('black') if cell.value == ' ♗ '
                    cell.piece = Queen.new('white') if cell.value == ' ♛ '
                    cell.piece = Queen.new('black') if cell.value == ' ♕ '
                    cell.piece = King.new('white') if cell.value == ' ♚ '
                    cell.piece = King.new('black') if cell.value == ' ♔ '
                end
            end
        end
    
        n1 = 0
        n2 = 0
        (1..50).each do |n|
            n1 = n * 2 - 1
            n2 = n * 2

            ending1 = turn('white', n1)

            if ending1 == 1
                puts 'Black won!'
                break
            elsif ending1 == 2
                puts 'Stalemate!'
                break
            end

            ending2 = turn('black', n2)

            if ending2 == 1
                puts 'White won!'
                break
            elsif ending2 == 2
                puts 'Stalemate'
                break
            end
        end
    end
end

#game = Board.new
#game.play

