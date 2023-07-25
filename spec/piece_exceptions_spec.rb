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
end