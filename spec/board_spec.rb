require './lib/board.rb'

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
                expect(board.board[0][0].x).to eq('a')
                expect(board.board[0][0].y).to eq(7)
                expect(board.board[7][0].x).to eq('a')
                expect(board.board[7][0].y).to eq(0)
                expect(board.board[7][7].x).to eq('h')
                expect(board.board[7][7].y).to eq(0)
            end
        end
    end

    describe '#letter_to_number' do
        subject(:board) {described_class.new}

        context 'when called' do
            it 'transforms letter to number' do
                expect(board.letter_to_number('a')).to eq(0)
                expect(board.letter_to_number('c')).to eq(2)
                expect(board.letter_to_number('h')).to eq(7)
            end
        end
    end
    
end