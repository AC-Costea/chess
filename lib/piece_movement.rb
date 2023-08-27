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

    def save_data
        @list_of_values = []
        for cell in @board.flatten
            @list_of_values << cell.value
        end
        data = {
            list_of_values: @list_of_values,
        }
        File.open('data.json', 'w') do |file|
            JSON.dump(data, file)
        end
    end

    def use_save_data
        json_data = File.read('/mnt/c/Users/const/downloads/repos/chess/data.json')
        save_data = JSON.parse(json_data)
        @list_of_values = save_data['list_of_values']
    end

    def input
        input = gets.chomp
        save_data() if input == 'save'
        until valid_input?(input)
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
            until n == y_array.length
                return false if piece?(@board[7 - (cell.y + y_array[n])][cell.x + x_array[n]])
                n +=1
            end
        else
            until n == x_array.length
                return true if y_array.length < x_array.length
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

    def unswap_piece(cell, destination, destination_piece, destination_value)
        value = cell.value
        piece = cell.piece
        cell.piece = destination.piece
        cell.value = destination.value
        destination.piece = destination_piece
        destination.value = destination_value
    end

    def check_board_pieces
        @white_pieces = []
        @black_pieces = []
        for cell in @board.flatten
            if cell.piece != nil && cell.piece.color == 'white'
                @white_pieces << cell
            elsif cell.piece != nil && cell.piece.color == 'black'
                @black_pieces << cell
            end
        end
    end

    def is_check?(king)
        check_board_pieces()
        if king.piece.color == 'white'
            for cell in @black_pieces
                if cell.piece.class.name.split("::").last == 'Pawn'
                    if no_obstacles?(@board[7 - cell.y][cell.x], @board[7 - king.y][king.x]) && valid_pawn_move?(@board[7 - cell.y][cell.x], @board[7 - king.y][king.x]) && valid_destination?(@board[7 - cell.y][cell.x], @board[7 - king.y][king.x])
                        return true
                    end
                else
                    if no_obstacles?(@board[7 - cell.y][cell.x], @board[7 - king.y][king.x]) && valid_move?(@board[7 - cell.y][cell.x], @board[7 - king.y][king.x]) && valid_destination?(@board[7 - cell.y][cell.x], @board[7 - king.y][king.x])
                        return true
                    end
                end
            end
        elsif king.piece.color == 'black'
            for cell in @white_pieces
                if cell.piece.class.name.split("::").last == 'Pawn'
                    if no_obstacles?(@board[7 - cell.y][cell.x], @board[7 - king.y][king.x]) && valid_pawn_move?(@board[7 - cell.y][cell.x], @board[7 - king.y][king.x]) && valid_destination?(@board[7 - cell.y][cell.x], @board[7 - king.y][king.x])
                        return true
                    end
                else
                    if no_obstacles?(@board[7 - cell.y][cell.x], @board[7 - king.y][king.x]) && valid_move?(@board[7 - cell.y][cell.x], @board[7 - king.y][king.x]) && valid_destination?(@board[7 - cell.y][cell.x], @board[7 - king.y][king.x])
                        return true
                    end
                end
            end
        end
        return false
    end

    def find_king(color)
        for cell in @board.flatten
            if cell.piece != nil
                return cell if cell.piece.color == color && cell.piece.class.name.split("::").last == 'King'
            end
        end
    end

    def move_piece(color, round)
        cell = select_piece(color)
        destination = select_destination()
        direction = destination.x - cell.x
        destination_value = destination.value
        destination_piece = destination.piece

        if cell.piece.class.name.split("::").last == 'Pawn'
            cell.piece.round = round
            if valid_pawn_move?(cell, destination) && valid_destination?(cell, destination) && no_obstacles?(cell, destination)
                cell.piece.moves_made += 1
                piece_swapper(cell, destination)
                promote_pawn(destination) if destination.y == 0 || destination.y == 7
                if is_check?(find_king(color))
                    unswap_piece(cell, destination, destination_piece, destination_value)
                    puts 'Your king is in check'
                    return false
                end
                return true
            end

        elsif cell.piece.class.name.split("::").last == 'King' && (direction == 2 || direction == -2)
            if castle?(cell, direction)
                if direction == 2
                    piece_swapper(@board[7 - cell.y][7], @board[7 - cell.y][cell.x + 1])
                elsif direction == -2
                    piece_swapper(@board[7 - cell.y][0], @board[7 - cell.y][cell.x - 1])
                end
                cell.piece.moves_made += 1
                piece_swapper(cell, destination)
                return true
            end
        else
            if valid_move?(cell, destination) && valid_destination?(cell, destination) && no_obstacles?(cell, destination)
                if cell.piece.class.name.split("::").last == 'Rook' || cell.piece.class.name.split("::").last == 'King'
                    cell.piece.moves_made += 1
                end
                piece_swapper(cell, destination)
                if is_check?(find_king(color))
                    unswap_piece(cell, destination, destination_piece, destination_value)
                    puts 'Your king is in check'
                    return false
                end
                return true
            end
        end
        if cell.piece.class.name.split("::").last == 'Pawn'
            cell.piece.round -= 1
        end
        puts 'Invalid move, try again !'
        return false
    end
end