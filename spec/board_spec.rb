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

    
    describe 'set_pieces' do
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
end