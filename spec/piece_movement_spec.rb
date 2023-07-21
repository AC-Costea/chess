require './lib/board.rb'

describe Board do
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

    describe '#valid_move?' do
        subject(:game) {described_class.new}

        context 'when pawn valid move' do
            before do
                game.create_board
                game.set_pieces
            end

            it 'returns true' do
                expect(game.valid_move?(game.board[6][6], game.board[4][6])).to be true
                expect(game.valid_move?(game.board[1][1], game.board[3][1])).to be true
                expect(game.valid_move?(game.board[6][6], game.board[5][6])).to be true
                expect(game.valid_move?(game.board[1][1], game.board[2][1])).to be true
            end
        end

        context 'when pawn invalid move' do
            before do
                game.create_board
                game.set_pieces
            end

            it 'returns false' do
                expect(game.valid_move?(game.board[6][6], game.board[2][6])).to be false
                expect(game.valid_move?(game.board[1][1], game.board[3][2])).to be false
                expect(game.valid_move?(game.board[6][6], game.board[7][6])).to be false
                expect(game.valid_move?(game.board[1][1], game.board[2][5])).to be false
            end
        end

        context 'when rook valid move' do
            before do
                game.create_board
                game.set_pieces
            end

            it 'returns true' do
                expect(game.valid_move?(game.board[7][7], game.board[7][5])).to be true
                expect(game.valid_move?(game.board[7][7], game.board[5][7])).to be true
                expect(game.valid_move?(game.board[0][0], game.board[6][0])).to be true
                expect(game.valid_move?(game.board[0][0], game.board[0][4])).to be true
            end
        end

        context 'when rook invalid move' do
            before do
                game.create_board
                game.set_pieces
            end

            it 'returns false' do
                expect(game.valid_move?(game.board[7][0], game.board[2][6])).to be false
                expect(game.valid_move?(game.board[7][0], game.board[3][2])).to be false
                expect(game.valid_move?(game.board[0][7], game.board[7][6])).to be false
                expect(game.valid_move?(game.board[0][7], game.board[2][5])).to be false
            end
        end

        context 'when knight valid move' do
            before do
                game.create_board
                game.set_pieces
            end

            it 'returns true' do
                expect(game.valid_move?(game.board[7][6], game.board[6][4])).to be true
                expect(game.valid_move?(game.board[7][6], game.board[5][7])).to be true
                expect(game.valid_move?(game.board[0][6], game.board[2][7])).to be true
                expect(game.valid_move?(game.board[0][6], game.board[1][4])).to be true
            end
        end

        context 'when knight invalid move' do
            before do
                game.create_board
                game.set_pieces
            end

            it 'returns false' do
                expect(game.valid_move?(game.board[7][6], game.board[2][6])).to be false
                expect(game.valid_move?(game.board[7][1], game.board[3][2])).to be false
                expect(game.valid_move?(game.board[0][1], game.board[7][6])).to be false
                expect(game.valid_move?(game.board[0][6], game.board[2][4])).to be false
            end
        end

        context 'when bishop valid move' do
            before do
                game.create_board
                game.set_pieces
            end
    
            it 'returns true' do
                expect(game.valid_move?(game.board[7][5], game.board[5][3])).to be true
                expect(game.valid_move?(game.board[7][5], game.board[5][7])).to be true
                expect(game.valid_move?(game.board[0][5], game.board[1][6])).to be true
                expect(game.valid_move?(game.board[0][5], game.board[5][0])).to be true
            end
        end
    
        context 'when bishop invalid move' do
            before do
                game.create_board
                game.set_pieces
            end
    
            it 'returns false' do
                expect(game.valid_move?(game.board[7][2], game.board[2][6])).to be false
                expect(game.valid_move?(game.board[7][2], game.board[3][2])).to be false
                expect(game.valid_move?(game.board[0][2], game.board[7][6])).to be false
                expect(game.valid_move?(game.board[0][2], game.board[2][7])).to be false
            end
        end

        context 'when queen valid move' do
            before do
                game.create_board
                game.set_pieces
            end
    
            it 'returns true' do
                expect(game.valid_move?(game.board[7][3], game.board[5][3])).to be true
                expect(game.valid_move?(game.board[7][3], game.board[5][5])).to be true
                expect(game.valid_move?(game.board[0][3], game.board[0][6])).to be true
                expect(game.valid_move?(game.board[0][3], game.board[0][0])).to be true
            end
        end
    
        context 'when queen invalid move' do
            before do
                game.create_board
                game.set_pieces
            end
    
            it 'returns false' do
                expect(game.valid_move?(game.board[7][3], game.board[2][6])).to be false
                expect(game.valid_move?(game.board[7][3], game.board[3][2])).to be false
                expect(game.valid_move?(game.board[0][3], game.board[7][6])).to be false
                expect(game.valid_move?(game.board[0][3], game.board[2][7])).to be false
            end
        end

        context 'when king valid move' do
            before do
                game.create_board
                game.set_pieces
            end
    
            it 'returns true' do
                expect(game.valid_move?(game.board[7][4], game.board[6][3])).to be true
                expect(game.valid_move?(game.board[7][4], game.board[7][5])).to be true
                expect(game.valid_move?(game.board[0][4], game.board[0][3])).to be true
                expect(game.valid_move?(game.board[0][4], game.board[1][5])).to be true
            end
        end
    
        context 'when king invalid move' do
            before do
                game.create_board
                game.set_pieces
            end
    
            it 'returns false' do
                expect(game.valid_move?(game.board[7][4], game.board[2][6])).to be false
                expect(game.valid_move?(game.board[7][4], game.board[3][2])).to be false
                expect(game.valid_move?(game.board[0][4], game.board[7][6])).to be false
                expect(game.valid_move?(game.board[0][4], game.board[2][7])).to be false
            end
        end
    end

    describe '#valid_destination?' do
        subject (:game) {described_class.new}

        context 'when empty square' do
            before do
                game.create_board
                game.set_pieces
            end

            it 'returns true' do
                expect(game.valid_destination?(game.board[6][6], game.board[4][6])).to be true
                expect(game.valid_destination?(game.board[7][6], game.board[5][7])).to be true
            end
        end

        context 'when  opposite color' do
            before do
                game.create_board
                game.set_pieces
            end

            it 'returns true' do
                expect(game.valid_destination?(game.board[6][6], game.board[1][1])).to be true
                expect(game.valid_destination?(game.board[7][6], game.board[0][0])).to be true
            end
        end

        context 'when  same color' do
            before do
                game.create_board
                game.set_pieces
            end

            it 'returns false' do
                expect(game.valid_destination?(game.board[6][6], game.board[6][1])).to be false
                expect(game.valid_destination?(game.board[7][6], game.board[7][0])).to be false
            end
        end
    end

    describe '#number_to_zero' do
        subject(:game) {described_class.new}

        context 'when called' do

            it 'creates an array with elements from x to zero' do
                expect(game.number_to_zero(-4)).to eq([-1, -2, -3])
            end
        end
    end

    describe '#zero_to_number' do
        subject(:game) {described_class.new}

        context 'when called' do

            it 'creates an array with elements from x to zero' do
                expect(game.zero_to_number(4)).to eq([1, 2, 3])
            end
        end
    end

    describe '#zero_maker' do
        subject(:game) {described_class.new}

        context 'when called' do

            it 'creates an array n number of zero' do
                expect(game.zero_maker(4)).to eq([0, 0, 0])
            end
        end
    end

    describe '#make_array' do

        subject(:game) {described_class.new}

        context 'when n > 0' do

            it 'creates array of numbers from 1 to n-1' do
                expect(game.make_array(5, 7)).to eq([1, 2, 3, 4])
            end
        end

        context 'when n < 0' do

            it 'creates array of numbers from n+1 to -1' do
                expect(game.make_array(-5, 7)).to eq([-1, -2, -3, -4])
            end
        end
        context 'when n == 0' do

            it 'creates array of n zeros' do
                expect(game.make_array(0, 7)).to eq([0, 0, 0, 0, 0, 0])
            end
        end
    end

    describe '#piece?' do

        subject(:game) {described_class.new}

        context 'when cell has piece' do
            before do
                game.create_board
                game.set_pieces
            end

            it 'returns true' do 
                expect(game.piece?(game.board[7][4])).to eq true
            end
        end

        context 'when cell does not have piece' do
            before do
                game.create_board
                game.set_pieces
            end

            it 'returns true' do 
                expect(game.piece?(game.board[5][4])).to eq false
            end
        end
    end

    describe '#no_obstacles?' do
        subject(:game) {described_class.new}

        context 'when no obstacles' do
            before do
                game.create_board
                game.set_pieces
            end

            it 'returns true' do
                expect(game.no_obstacles?(game.board[6][6], game.board[4][6])).to be true
                expect(game.no_obstacles?(game.board[1][1], game.board[2][1])).to be true
            end
        end

        context 'when obstacles' do
            before do
                game.create_board
                game.set_pieces
            end

            it 'returns false' do
                expect(game.no_obstacles?(game.board[0][0], game.board[4][0])).to be false
                expect(game.no_obstacles?(game.board[7][5], game.board[5][3])).to be false
                expect(game.no_obstacles?(game.board[0][2], game.board[4][6])).to be false
                expect(game.no_obstacles?(game.board[0][3], game.board[4][7])).to be false
            end
        end

        context 'when moving one square' do
            before do
                game.create_board
                game.set_pieces
            end

            it 'returns true' do
                expect(game.no_obstacles?(game.board[0][0], game.board[1][0])).to be true
                expect(game.no_obstacles?(game.board[0][4], game.board[1][5])).to be true
                expect(game.no_obstacles?(game.board[7][5], game.board[6][4])).to be true
                expect(game.no_obstacles?(game.board[7][5], game.board[6][4])).to be true
            end
        end

        context 'when knight moves' do
            before do
                game.create_board
                game.set_pieces
            end

            it 'returns true regardless of obstacles' do
                expect(game.no_obstacles?(game.board[0][1], game.board[2][2])).to be true
            end
        end

    end

    describe '#move_piece' do
        subject(:game) {described_class.new}

        context 'when input is valid' do
            before do
                game.create_board
                game.set_pieces
                allow(game).to receive(:select_piece).and_return(game.board[1][1])
                allow(game).to receive(:select_destination).and_return(game.board[3][1])
            end

            it 'replaces the piece of the destination with selected piece' do
                game.move_piece
                expect(game.board[3][1].piece.class.name.split("::").last).to eq('Pawn')
            end

            it 'replaces the value of the destination with selected piece' do
                game.move_piece
                expect(game.board[3][1].value).to eq(' ♙ ')
            end

            it 'changes the previous positions piece to nil' do
                game.move_piece
                expect(game.board[1][1].piece).to eq(nil)
            end

            it "replaces the value of the previous position with '-' " do
                game.move_piece
                expect(game.board[1][1].value).to eq(' - ')
            end

            it "returns true" do
                expect(game.move_piece).to eq(true)
            end
        end

        context 'when input is invalid' do
            before do
                game.create_board
                game.set_pieces
                allow(game).to receive(:select_piece).and_return(game.board[1][1])
                allow(game).to receive(:select_destination).and_return(game.board[4][1])
            end

            it 'returns false' do
                expect(game.move_piece).to eq(false)
            end

            it 'outputs error message' do
                expect { game.move_piece }.to output("Invalid move !\n").to_stdout
            end
        end
    end
end