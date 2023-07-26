require 'pry'

module Piece_exceptions

    def en_passant?(selected_pawn, attacked_pawn)
        if attacked_pawn.piece.moves_made > 1 || attacked_pawn.piece.moves_made < 1
            return false
        elsif attacked_pawn.piece.round != selected_pawn.piece.round
            return false
        elsif attacked_pawn.piece.color == 'black'
            return false if attacked_pawn.y == 5
        elsif attacked_pawn.piece.color == 'white'
            return false if attacked_pawn.y == 2
        elsif selected_pawn.piece.color == 'black'
            return false if selected_pawn.y > 3
        elsif selected_pawn.piece.color == 'white'
            return false if selected_pawn.y < 4
        end
        return true
    end

    def valid_pawn_move?(cell, destination)
        piece_move = [destination.x - cell.x, destination.y - cell.y]

        if cell.piece.color  == 'black' && destination.piece == nil && cell.y == 6

            if piece_move == cell.piece.moveset_black[0] || piece_move == cell.piece.moveset_black[1]
                return true
            end
        elsif cell.piece.color  == 'white' && destination.piece == nil && cell.y == 1

            if piece_move == cell.piece.moveset_white[0] || piece_move == cell.piece.moveset_white[1]
                return true
            end
        elsif cell.piece.color  == 'black' && destination.piece == nil && cell.y != 6
            return true if piece_move == cell.piece.moveset_black[1]
        elsif cell.piece.color  == 'white' && destination.piece == nil && cell.y != 1
            return true if piece_move == cell.piece.moveset_white[1]
        elsif cell.piece.color  == 'black' && destination.piece != nil

            if piece_move == cell.piece.moveset_black_attack[0] || piece_move == cell.piece.moveset_black_attack[1]
                return true
            end
        elsif cell.piece.color  == 'white' && destination.piece != nil
            
            if piece_move == cell.piece.moveset_white_attack[0] || piece_move == cell.piece.moveset_white_attack[1]
                return true
            end
        end
        return false
    end
end