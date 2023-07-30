require 'pry'
require_relative 'piece_exceptions.rb'
module Piece_movement

    include Piece_exceptions
    def check_piece(cell, color)
        if cell.piece == nil
            return false
        elsif
            cell.piece.color != color
            return false
        else
            return true
        end
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
        return input
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

    def select_piece(color)
        coord = get_coordinates()
        loop do
            break if check_piece(@board[7 - coord[1]][coord[0]], color)
            puts "Select a #{color} piece"
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
                if piece_move == move
                    return true
                end
            end
        end
        return false
    end

    def valid_destination?(cell, destination)
        if destination.piece == nil
            return true
        elsif destination.piece.color != cell.piece.color
            return true
        else
            return false
        end
    end

    def number_to_zero(number)
        array = []
        number += 1
        (number...0).each do |n|
            array << n
        end
        return array.reverse
    end

    def zero_to_number(number)
        array = []
        (1...number).each do |n|
            array << n
        end
        return array
    end

    def zero_maker(number)
        array =[]
        number -= 1
        number.times do
            array << 0
        end

        return array
    end

    def make_array(a, b)
        if a > 0
            array = zero_to_number(a)
        elsif a < 0
            array = number_to_zero(a)
        elsif a == 0
            array = zero_maker(b.abs)
        elsif a == 0
            array = zero_maker(b.abs)       
        else 
            return false
    
        end
        return array
    end

    def piece?(cell)
        if cell.piece != nil
            return true
        else
            false
        end
    end

    def no_obstacles?(cell, destination)
        x = destination.x - cell.x
        y = destination.y - cell.y
        x_array = make_array(x, y)
        y_array = make_array(y, x)

        x = x.abs
        y = y.abs
        n = 0

        if x == 0
            unless n == y_array.length
                return false if piece?(@board[7 - (cell.y + y_array[n])][cell.x + x_array[n]])
                n +=1
            end
        else
            unless n == x_array.length 
                return false if piece?(@board[7 - (cell.y + y_array[n])][cell.x + x_array[n]])
                n +=1
            end
        end
        return true
    end

    def piece_swapper(cell, destination)
        destination.piece = cell.piece
        destination.value = cell.value
        cell.piece = nil
        cell.value = ' - '
    end

    def move_piece(color)
        cell = select_piece(color)
        destination = select_destination()

        if cell.piece.class.name.split("::").last == 'Pawn'
            if valid_pawn_move?(cell, destination) && valid_destination?(cell, destination) && no_obstacles?(cell, destination)
                piece_swapper(cell, destination)
                return true
            end
            
        else
            if valid_move?(cell, destination) && valid_destination?(cell, destination) && no_obstacles?(cell, destination)
                piece_swapper(cell, destination)
                return true
            end
        end
        puts 'Invalid move, try again !'
        return false
    end
end