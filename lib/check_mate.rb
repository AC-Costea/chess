require 'pry'
require_relative 'piece_movement.rb'

module Checkmate
    include Piece_movement

    def verify_move_and_check(piece, king, move)
        y = 7 - piece.y + move[1]
        x = piece.x + move[0]
        if (y >= 0 && y <= 7) && (x >= 0 && x <= 7)
            destination = @board[y][x]
            destination_piece = destination.piece
            destination_value = destination.value
            if piece.piece.class.name.split("::").last == 'Pawn'
                if valid_pawn_move?(piece, destination) && valid_destination?(piece, destination) && no_obstacles?(piece, destination)
                    piece_swapper(piece, destination)
                    if not is_check?(king)
                        unswap_piece(piece, destination, destination_piece, destination_value)
                        return false
                    end
                    unswap_piece(piece, destination, destination_piece, destination_value)
                end
            else
                if valid_move?(piece, destination) && valid_destination?(piece, destination) && no_obstacles?(piece, destination)        
                    piece_swapper(piece, destination)
                    if not is_check?(king)
                        unswap_piece(piece, destination, destination_piece, destination_value)
                        return false
                    end
                    unswap_piece(piece, destination, destination_piece, destination_value)
                end
            end
        end
    end

    def is_checkmate?(color)
        king = find_king(color)
        return false if not is_check?(king)
        for move in king.piece.moveset
            y = 7 - king.y + move[1]
            x = king.x + move[0]

            if (y >= 0 && y <= 7) && (x >= 0 && x <= 7)
                destination = @board[y][x]
                destination_piece = destination.piece
                destination_value = destination.value
                if valid_move?(king, destination) && valid_destination?(king, destination) && no_obstacles?(king, destination)   
                    piece_swapper(king, destination)
                    if not is_check?(destination)
                        unswap_piece(king, destination, destination_piece, destination_value)
                        return false
                    end
                    unswap_piece(king, destination, destination_piece, destination_value)
                end
            end
        end

        check_board_pieces()
        piece_list = nil
        if color == 'white'
            piece_list = @white_pieces
        elsif color == 'black'
            piece_list = @black_pieces
        end

        piece_list.reject! {|piece| piece.piece.class.name.split("::").last == 'King'}
        if piece_list.length != 0
            for piece in piece_list
                if piece.piece.class.name.split("::").last == 'Pawn' && piece.piece.color == 'white'
                    for move in piece.piece.moveset_white
                        if verify_move_and_check(piece, king, move) == false
                            return false
                        end
                    end

                    for move in piece.piece.moveset_white_attack
                        if verify_move_and_check(piece, king, move) == false
                            return false
                        end
                    end

                elsif piece.piece.class.name.split("::").last == 'Pawn' && piece.piece.color == 'black'
                    for move in piece.piece.moveset_black
                        if verify_move_and_check(piece, king, move) == false
                            return false
                        end
                    end

                    for move in piece.piece.moveset_black_attack
                        if verify_move_and_check(piece, king, move) == false
                            return false
                        end
                    end

                else 
                    for move in piece.piece.moveset
                        if verify_move_and_check(piece, king, move) == false
                            return false
                        end
                    end
                end
            end
        end
        return true
    end

    def is_stalemate?(color)
        king = find_king(color)
        return false if is_check?(king)
        
        check_board_pieces()
        return true if @white_pieces.length == 1 && @white_pieces.last.piece.class.name.split("::").last == 'King' && @black_pieces.length == 1 && @black_pieces.last.piece.class.name.split("::").last == 'King'
        
        for move in king.piece.moveset
            y = 7 - king.y + move[1]
            x = king.x + move[0]

            if (y >= 0 && y <= 7) && (x >= 0 && x <= 7)
                destination = @board[y][x]
                destination_piece = destination.piece
                destination_value = destination.value
                if valid_move?(king, destination) && valid_destination?(king, destination) && no_obstacles?(king, destination)   
                    piece_swapper(king, destination)
                    if not is_check?(destination)
                        unswap_piece(king, destination, destination_piece, destination_value)
                        return false
                    end
                    unswap_piece(king, destination, destination_piece, destination_value)
                end
            end
        end

        check_board_pieces()
        piece_list = nil
        if color == 'white'
            piece_list = @white_pieces
        elsif color == 'black'
            piece_list = @black_pieces
        end

        piece_list.reject! {|piece| piece.piece.class.name.split("::").last == 'King'}
        if piece_list.length != 0
            for piece in piece_list
                if piece.piece.class.name.split("::").last == 'Pawn' && piece.piece.color == 'white'
                    for move in piece.piece.moveset_white
                        if verify_move_and_check(piece, king, move) == false
                            return false
                        end
                    end

                    for move in piece.piece.moveset_white_attack
                        if verify_move_and_check(piece, king, move) == false
                            return false
                        end
                    end

                elsif piece.piece.class.name.split("::").last == 'Pawn' && piece.piece.color == 'black'
                    for move in piece.piece.moveset_black
                        if verify_move_and_check(piece, king, move) == false
                            return false
                        end
                    end

                    for move in piece.piece.moveset_black_attack
                        if verify_move_and_check(piece, king, move) == false
                            return false
                        end
                    end

                else 
                    for move in piece.piece.moveset
                        if verify_move_and_check(piece, king, move) == false
                            return false
                        end
                    end
                end
            end
        end
        return true
    end
end
