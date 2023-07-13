require 'pry'

module Piece_movement

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
        letters = {'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4, 'f' => 5, 'g' => 6, 'h' => 7}
        letters.fetch(letter)
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

    def valid_move?(cell, destination)
        piece_move = [destination.x - cell.x, destination.y - cell.y]
       # binding.pry
        if cell.piece.color  == 'black' && cell.piece.class.name.split("::").last == 'Pawn'
            for move in cell.piece.moveset_black
                if piece_move == move
                    return true
                end
            end

        elsif cell.piece.color  == 'white' && cell.piece.class.name.split("::").last == 'Pawn'
            for move in cell.piece.moveset_white
                if piece_move == move
                    return true
                end
            end
            
        else
            for move in cell.piece.moveset
                #binding.pry
                if piece_move == move
                    return true
                end
            end
        end
        return false
    end

end