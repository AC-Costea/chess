require 'pry'

module Piece_exceptions

    def valid_pawn_move?(cell, destination)
        piece_move = [destination.x - cell.x, destination.y - cell.y]

        if cell.piece.color  == 'black' && destination.piece == nil
            for move in cell.piece.moveset_black
                if piece_move == move
                    return true
                end
            end

        elsif cell.piece.color  == 'white' && destination.piece == nil
            for move in cell.piece.moveset_white
                if piece_move == move
                    return true
                end
            end
        end
    end
end