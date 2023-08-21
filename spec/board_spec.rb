require './lib/board.rb'
require './lib/pieces/pawn.rb'
require './lib/piece_movement.rb'
require './lib/piece_exceptions.rb'

describe Board do

    describe '#create_board' do
        subject(:board) {described_class.new}

        context 'when it called' do
            before do
                board.create_board
            end

            it 'makes an array of 8 arrays' do
                expect(board.board.length).to eq(8)
            end

            it 'creates inner arrays of 8 elements' do
                expect(board.board[0].length).to eq(8)
            end

            it 'creates ordered inner arrays' do
                expect(board.board[0][0].x).to eq(0)
                expect(board.board[0][0].y).to eq(7)
                expect(board.board[7][0].x).to eq(0)
                expect(board.board[7][0].y).to eq(0)
                expect(board.board[7][7].x).to eq(7)
                expect(board.board[7][7].y).to eq(0)
            end
        end
    end

    
    describe '#set_pieces' do
        subject(:board) {described_class.new}

        context 'when called' do
            before do
                board.create_board
            end

            it 'sets the pawns' do
                board.set_pieces
                expect(board.board[1][0].piece.is_a? Object).to be true
                expect(board.board[1][7].piece.is_a? Object).to be true
                expect(board.board[6][0].piece.is_a? Object).to be true
                expect(board.board[6][7].piece.is_a? Object).to be true
            end

        end
    end

    describe '#turn' do
        subject(:game) {described_class.new}

        context "when white is checkmated (Fool's Mate)" do
            before do
                game.create_board
                game.set_pieces
                game.board[6][6].piece = nil
                game.board[6][5].piece = nil
                game.board[4][6].piece = Pawn.new('white')
                game.board[5][5].piece = Pawn.new('white')
                game.board[0][3].piece = nil
                game.board[4][7].piece = Queen.new('black')
                game.board[2][4].piece = Pawn.new('black')
                game.board[1][4].piece = nil  
            end

            it 'returns 1' do
                expect(game.turn('white', 2)).to eq(1)
            end
        end

        context "when black is checkmated (Fool's Mate)" do
            before do
                game.create_board
                game.set_pieces
                game.board[6][5].piece = nil
                game.board[6][4].piece = nil
                game.board[4][4].piece = Pawn.new('white')
                game.board[4][5].piece = Pawn.new('white')
                game.board[1][5].piece = nil
                game.board[1][6].piece = nil
                game.board[7][3].piece = nil
                game.board[3][7].piece = Queen.new('white')
                game.board[2][5].piece = Pawn.new('black')
                game.board[3][5].piece = Pawn.new('black')    
            end

            it 'returns 1' do
                expect(game.turn('black', 2)).to eq(1)
            end
        end
    end
end