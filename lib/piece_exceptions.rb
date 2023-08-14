require 'pry'

module Piece_exceptions

    def en_passant?(selected_pawn, attacked_pawn)
        if attacked_pawn.piece.moves_made > 1 || attacked_pawn.piece.moves_made < 1
            return false
        elsif selected_pawn.piece.round != attacked_pawn.piece.round + 1
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
        attacked_pawn.piece = nil
        attacked_pawn.value = ' - '
        return true
    end

    def valid_pawn_move?(cell, destination)
        piece_move = [destination.x - cell.x, destination.y - cell.y]
        
        if cell.piece.color  == 'black' && destination.piece == nil && cell.y == 6
            return true if piece_move == cell.piece.moveset_black[0] || piece_move == cell.piece.moveset_black[1] 
        elsif cell.piece.color  == 'white' && destination.piece == nil && cell.y == 1
            return true if piece_move == cell.piece.moveset_white[0] || piece_move == cell.piece.moveset_white[1]
        elsif cell.piece.color  == 'black' && destination.piece == nil && cell.y != 6
            return en_passant?(cell, @board[7 - cell.y][cell.x - 1]) if piece_move == cell.piece.moveset_black_attack[1] 
            return en_passant?(cell, @board[7 - cell.y][cell.x + 1]) if piece_move == cell.piece.moveset_black_attack[0]
            return true if piece_move == cell.piece.moveset_black[1]
        elsif cell.piece.color  == 'white' && destination.piece == nil && cell.y != 1
            return en_passant?(cell, @board[7 - cell.y][cell.x - 1]) if piece_move == cell.piece.moveset_white_attack[1] 
            return en_passant?(cell, @board[7 - cell.y][cell.x + 1]) if piece_move == cell.piece.moveset_white_attack[0]
            return true if piece_move == cell.piece.moveset_white[1]
        elsif cell.piece.color  == 'black' && destination.piece != nil
            return true if piece_move == cell.piece.moveset_black_attack[0] || piece_move == cell.piece.moveset_black_attack[1]
        elsif cell.piece.color  == 'white' && destination.piece != nil
            return true if piece_move == cell.piece.moveset_white_attack[0] || piece_move == cell.piece.moveset_white_attack[1]
        end
        return false
    end

    def promote_pawn(cell)
        available_pieces = ['knight', 'bishop', 'queen', 'rook']
        input = gets.chomp.downcase
        until available_pieces.include?(input)
            puts 'You can only promote to a rook, a bishop, a knight or a queen'
            input = gets.chomp.downcase
        end
        if cell.y == 0
            if input == 'knight'
                cell.piece = Knight.new('black')
                cell.value = ' ♘ '
            elsif input == 'bishop'
                cell.piece = Bishop.new('black')
                cell.value = ' ♗ '
            elsif input == 'rook'
                cell.piece = Rook.new('black')
                cell.value = ' ♖ '
            elsif input == 'queen'
                cell.piece = Queen.new('black')
                cell.value = ' ♕ '
            end
        elsif cell.y == 7
            if input == 'knight'
                cell.piece = Knight.new('white')
                cell.value = ' ♞ '
            elsif input == 'bishop'
                cell.piece = Bishop.new('white')
                cell.value = ' ♝ '
            elsif input == 'rook'
                cell.piece = Rook.new('white')
                cell.value = ' ♜ '
            elsif input == 'queen'
                cell.piece = Queen.new('white')
                cell.value = ' ♛ '
            end
        end
    end

    def castle?(king, direction)
        if king.piece.color == 'white' 
            if direction == 2
                rook = @board[7][7]
            elsif direction == -2
                rook = @board[7][0]
            end
        elsif king.piece.color == 'black'
            if direction == 2
                rook = @board[0][7]
            elsif direction == -2
                rook = @board[0][0]
            end
        end

        if rook.piece.class.name.split("::").last != 'Rook'
            return false
        else
            if rook.piece.moves_made > 0 || king.piece.moves_made > 0
                return false
            end

            if not no_obstacles?(king, rook)
                return false
            end

            if is_check?(king)
                return false
            end
            
            if direction == 2
                @board[7 - king.y][king.x + direction - 1].piece = King.new(king.piece.color)
                @board[7 - king.y][king.x + direction].piece = King.new(king.piece.color)

                if is_check?(@board[7 - king.y][king.x + direction - 1]) || is_check?(@board[7 - king.y][king.x + direction])
                    @board[7 - king.y][king.x + direction - 1].piece = nil
                    @board[7 - king.y][king.x + direction].piece = nil
                    return false
                end
            else
                @board[7 - king.y][king.x + direction + 1].piece = King.new(king.piece.color)
                @board[7 - king.y][king.x + direction].piece = King.new(king.piece.color)

                if is_check?(@board[7 - king.y][king.x + direction + 1]) || is_check?(@board[7 - king.y][king.x + direction])
                    @board[7 - king.y][king.x + direction + 1].piece = nil
                    @board[7 - king.y][king.x + direction].piece = nil
                    return false
                end
            end
        end
        return true
    end
end