require './lib/board.rb'


describe Board do
    describe '#valid_pawn_move' do
        subject(:game) {described_class.new}

        context 'when in starting position' do
            before do
                game.create_board
                game.set_pieces
            end

            it 'can move two squares' do
                expect(game.valid_pawn_move?(game.board[6][6], game.board[4][6])).to be true
                expect(game.valid_pawn_move?(game.board[1][1], game.board[3][1])).to be true
            end

            it 'can move one square' do
                expect(game.valid_pawn_move?(game.board[6][6], game.board[5][6])).to be true
                expect(game.valid_pawn_move?(game.board[1][1], game.board[2][1])).to be true
            end
        end

        context 'when not in starting position' do
            before do
                game.create_board
                game.set_pieces
                game.board[5][6].value = ' ♟︎ '
                game.board[5][6].piece = Pawn.new('white')
                game.board[2][1].value = ' ♙ '
                game.board[2][1].piece = Pawn.new('black')
            end

            it 'can move one square' do
                expect(game.valid_pawn_move?(game.board[5][6], game.board[4][6])).to be true
                expect(game.valid_pawn_move?(game.board[2][1], game.board[3][1])).to be true
            end

            it 'cannot move two squares' do
                expect(game.valid_pawn_move?(game.board[5][6], game.board[3][6])).to be false
                expect(game.valid_pawn_move?(game.board[2][1], game.board[4][1])).to be false
            end
        end

        context 'when attacking' do
            before do
                game.create_board
                game.set_pieces
                game.board[5][6].piece = Pawn.new('black')
                game.board[2][1].piece = Pawn.new('white')
                game.board[5][4].piece = Pawn.new('black')
                game.board[2][5].piece = Pawn.new('white')
            end

            it 'can move one square diagonally to the right' do
                expect(game.valid_pawn_move?(game.board[6][5],  game.board[5][6])).to be true
                expect(game.valid_pawn_move?(game.board[1][4],  game.board[2][5])).to be true
            end

            it 'can move one square diagonally to the left' do
                expect(game.valid_pawn_move?(game.board[6][5],  game.board[5][4])).to be true
                expect(game.valid_pawn_move?(game.board[1][2],  game.board[2][1])).to be true
            end
        end
    end

    describe '#en_passant?' do
        subject(:game) {described_class.new}
        
        context 'when not traveled at least 3 ranks' do
            before do
                game.create_board
                game.set_pieces
                game.board[5][1].piece = Pawn.new('black')
                game.board[5][2].piece = Pawn.new('white')
                game.board[3][1].piece = Pawn.new('black')
                game.board[3][2].piece = Pawn.new('white')
            end

            it 'returns false' do
                expect(game.en_passant?(game.board[5][2], game.board[5][1])).to be false
                expect(game.en_passant?(game.board[3][1], game.board[3][2])).to be false
            end
        end

        context 'when attacked pawn made two moves' do
            before do
                game.create_board
                game.set_pieces
                game.board[3][1].piece = Pawn.new('black')
                game.board[3][2].piece = Pawn.new('white')
                game.board[3][1].piece.moves_made = 2
                game.board[5][1].piece = Pawn.new('black')
                game.board[5][2].piece = Pawn.new('white')
                game.board[5][2].piece.moves_made = 2
            end

            it 'returns false' do
                expect(game.en_passant?(game.board[3][2], game.board[3][1])).to be false
                expect(game.en_passant?(game.board[5][1], game.board[5][2])).to be false
            end
        end

        context 'when attacked pawn is not two squares in front' do
            before do
                game.create_board
                game.set_pieces
                game.board[2][1].piece = Pawn.new('black')
                game.board[2][2].piece = Pawn.new('white')
                game.board[2][1].piece.moves_made = 1
                game.board[5][1].piece = Pawn.new('black')
                game.board[5][2].piece = Pawn.new('white')
                game.board[5][2].piece.moves_made = 1
            end

            it 'returns false' do
                expect(game.en_passant?(game.board[2][2], game.board[2][1])).to be false
                expect(game.en_passant?(game.board[5][1], game.board[5][2])).to be false
            end
        end

        context 'when attacked_pawn and selected pawn have different rounds' do
            before do
                game.create_board
                game.set_pieces
                game.board[3][1].piece = Pawn.new('black')
                game.board[3][2].piece = Pawn.new('white')
                game.board[3][1].piece.moves_made = 1
                game.board[3][1].piece.round = 4
                game.board[3][2].piece.round = 5
                game.board[4][1].piece = Pawn.new('black')
                game.board[4][2].piece = Pawn.new('white')
                game.board[4][2].piece.moves_made = 1
                game.board[4][2].piece.round = 4
                game.board[4][1].piece.round = 5
            end

            it 'returns false' do
                expect(game.en_passant?(game.board[3][2], game.board[3][1])).to be false
                expect(game.en_passant?(game.board[4][1], game.board[4][2])).to be false
            end
        end

        context 'when all coditions are met' do
            before do
                game.create_board
                game.set_pieces
                game.board[3][1].piece = Pawn.new('black')
                game.board[3][2].piece = Pawn.new('white')
                game.board[3][1].piece.moves_made = 1
                game.board[3][1].piece.round = 4
                game.board[3][2].piece.round = 4
                game.board[4][1].piece = Pawn.new('black')
                game.board[4][2].piece = Pawn.new('white')
                game.board[4][2].piece.moves_made = 1
                game.board[4][2].piece.round = 5
                game.board[4][1].piece.round = 5
            end

            it 'returns true' do
                expect(game.en_passant?(game.board[3][2], game.board[3][1])).to be true
                expect(game.en_passant?(game.board[4][1], game.board[4][2])).to be true
            end
        end
    end
end