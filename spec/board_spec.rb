require './lib/board.rb'
require './lib/pieces/pawn.rb'

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
    
    describe '#valid_input?' do
        subject(:board) {described_class.new}

        context 'when invalid' do
            it 'returns false' do
                expect(board.valid_input?('jh')).to be false
                expect(board.valid_input?('j12')).to be false
                expect(board.valid_input?('j1')).to be false
                expect(board.valid_input?('12')).to be false
                expect(board.valid_input?('ab')).to be false
            end
        end

        context 'when valid' do
            it 'returns true' do
                expect(board.valid_input?('a2')).to be true
                expect(board.valid_input?('b6')).to be true
                expect(board.valid_input?('h8')).to be true
                expect(board.valid_input?('c5')).to be true
                expect(board.valid_input?('a8')).to be true
            end
        end
    end

    describe '#input' do
        subject(:board) { described_class.new }

        context 'when user inputs an incorrect value once, then a valid input' do
            before do
                letter = 'k'
                valid_input = 'a5'
                allow(board).to receive(:gets).and_return(letter, valid_input)
            end

            it 'outputs an error once' do
                expect(board).to receive(:puts).with('You must introduce a letter, then a number').once 
                board.input
            end

        end

        context 'when user inputs an incorrect value twice, than a valid input' do
            before do
                letter = 'k'
                symbol = '@'
                valid_input = 'd8'
                allow(board).to receive(:gets).and_return(letter, symbol, valid_input)
            end

            it 'outputs an error twice' do
                expect(board).to receive(:puts).with('You must introduce a letter, then a number').twice
                board.input
            end
        end

        context 'when user inputs an incorrect value thrice, than a valid input' do
            before do
                letter = 'k'
                symbol = '@'
                word = 'hello'
                valid_input = 'e3'
                allow(board).to receive(:gets).and_return(letter, symbol, word, valid_input)
            end

            it 'outputs and error thrice' do
                expect(board).to receive(:puts).with('You must introduce a letter, then a number').thrice
                board.input
            end
        end

        context 'when user input is valid' do

            it 'stops the loop and does not display an error message' do 
                valid_input = 'h6'
                allow(board).to receive(:gets).and_return(valid_input)
                expect(board).not_to receive(:puts).with('You must introduce a letter, then a number')
                board.input
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

    describe '#get_coordinates' do
        subject(:game) {described_class.new}

        context 'when called' do
            it 'returns correct coordinates' do
                allow(game).to receive(:input).and_return('a1')
                expect(game.get_coordinates).to eq([0, 0])
                allow(game).to receive(:input).and_return('c2')
                expect(game.get_coordinates).to eq([2, 1])
            end
        end
    end


    describe '#select_piece' do
        subject(:game) {described_class.new}

        context 'when not called on a piece once, then called on a piece' do
            before do
                game.create_board
                game.set_pieces
                invalid_input1 = [5, 5]
                valid_input = [1, 1]
                allow(game).to receive(:get_coordinates).and_return(invalid_input1, valid_input)
            end

            it 'outputs an error once' do
                expect(game).to receive(:puts).with('Select a piece').once 
                game.select_piece
            end
        end

        context 'when not called on a piece twice, then called on a piece' do
            before do
                game.create_board
                game.set_pieces
                invalid_input1 = [5, 5]
                invalid_input2 = [4, 3]
                valid_input = [0, 1]
                allow(game).to receive(:get_coordinates).and_return(invalid_input1, invalid_input2, valid_input)
            end

            it 'outputs an error twice' do
                expect(game).to receive(:puts).with('Select a piece').twice
                game.select_piece
            end
        end

        context 'when not called on a piece thrice, then called on a piece' do
            before do
                game.create_board
                game.set_pieces
                invalid_input1 = [5, 5]
                invalid_input2 = [4, 3]
                invalid_input3 = [3, 5]
                valid_input = [4, 6]
                allow(game).to receive(:get_coordinates).and_return(invalid_input1, invalid_input2, invalid_input3, valid_input)
            end

            it 'outputs an error trice' do
                expect(game).to receive(:puts).with('Select a piece').thrice
                game.select_piece
            end
        end

        context 'when called on a piece' do
            before do
                game.create_board
                game.set_pieces
                valid_input = [7, 7]
                allow(game).to receive(:get_coordinates).and_return(valid_input)
            end

            it 'stops the loop and does not display an error message' do 
                expect(game).not_to receive(:puts).with('Select a piece')
                game.select_piece
            end
        end
    end

    describe '#select_destination' do
        subject(:game) {described_class.new}

        context 'when called' do
            before do
                game.create_board
                game.set_pieces
                input = [3, 3]
                allow(game).to receive(:get_coordinates).and_return(input)
            end

            it 'outputs an error once' do
                expect(game.select_destination).to eq(game.board[4][3])
            end
        end
    end

    describe '#move_piece' do
        subject(:game) {described_class.new}

        context 'when called' do

        end
    end
end