require './lib/board.rb'

describe Board do
    describe '#is_check_mate?' do
        subject(:game) {described_class.new}

        context 'when no checkmate' do
            before do
                game.create_board
                game.board[0][4].piece = King.new('black')
                game.board[0][0].piece = Rook.new('white')
            end

            it 'returns true' do
                expect(game.is_check_mate?('black')).to be false
            end
        end
        
        context 'when two rook checkmate (black)' do
            before do
                game.create_board
                game.board[0][4].piece = King.new('black')
                game.board[0][0].piece = Rook.new('white')
                game.board[1][0].piece = Rook.new('white')
            end

            it 'returns true' do
                expect(game.is_check_mate?('black')).to be true
            end
        end

        context 'when two rook checkmate (white)' do
            before do
                game.create_board
                game.board[7][4].piece = King.new('white')
                game.board[7][0].piece = Rook.new('black')
                game.board[6][0].piece = Rook.new('black')
            end

            it 'returns true' do
                expect(game.is_check_mate?('white')).to be true
            end
        end

        context "Anastasia's mate (black)" do
            before do
                game.create_board
                game.board[1][7].piece = King.new('black')
                game.board[1][6].piece = Pawn.new('black')
                game.board[5][7].piece = Rook.new('white')
                game.board[1][4].piece = Knight.new('white')
            end

            it 'returns true' do
                expect(game.is_check_mate?('black')).to be true
            end
        end

        context "Anastasia's mate (white)" do
            before do
                game.create_board
                game.board[6][7].piece = King.new('white')
                game.board[6][6].piece = Pawn.new('white')
                game.board[3][7].piece = Rook.new('black')
                game.board[6][4].piece = Knight.new('black')
            end

            it 'returns true' do
                expect(game.is_check_mate?('white')).to be true
            end
        end

        context "Anderssen's Mate (black)" do
            before do
                game.create_board
                game.board[0][6].piece = King.new('black')
                game.board[1][6].piece = Pawn.new('white')
                game.board[2][5].piece = King.new('white')
                game.board[0][7].piece = Rook.new('white')
            end

            it 'returns true' do
                expect(game.is_check_mate?('black')).to be true
            end
        end

        context "Anderssen's Mate (white)" do
            before do
                game.create_board
                game.board[7][6].piece = King.new('white')
                game.board[6][6].piece = Pawn.new('black')
                game.board[5][5].piece = King.new('black')
                game.board[7][7].piece = Rook.new('black')
            end

            it 'returns true' do
                expect(game.is_check_mate?('white')).to be true
            end
        end

        context "Arabian Mate (black)" do
            before do
                game.create_board
                game.board[0][7].piece = King.new('black')
                game.board[2][5].piece = Knight.new('white')
                game.board[1][7].piece = Rook.new('white')
            end

            it 'returns true' do
                expect(game.is_check_mate?('black')).to be true
            end
        end

        context "Arabian Mate (white)" do
            before do
                game.create_board
                game.board[7][0].piece = King.new('white')
                game.board[5][2].piece = Knight.new('black')
                game.board[6][0].piece = Rook.new('black')
            end

            it 'returns true' do
                expect(game.is_check_mate?('white')).to be true
            end
        end

        context "Back Rank Mate (black)" do
            before do
                game.create_board
                game.board[0][6].piece = King.new('black')
                game.board[1][7].piece = Pawn.new('black')
                game.board[1][6].piece = Pawn.new('black')
                game.board[1][5].piece = Pawn.new('black')
                game.board[0][4].piece = Rook.new('white')
            end

            it 'returns true' do
                expect(game.is_check_mate?('black')).to be true
            end
        end

        context "Back Rank Mate (white)" do
            before do
                game.create_board
                game.board[7][6].piece = King.new('white')
                game.board[6][7].piece = Pawn.new('white')
                game.board[6][6].piece = Pawn.new('white')
                game.board[6][5].piece = Pawn.new('white')
                game.board[7][4].piece = Rook.new('black')
            end

            it 'returns true' do
                expect(game.is_check_mate?('white')).to be true
            end
        end

        context "Balestra Mate (black)" do
            before do
                game.create_board
                game.board[0][4].piece = King.new('black')
                game.board[2][5].piece = Queen.new('white')
                game.board[2][2].piece = Bishop.new('white')
            end

            it 'returns true' do
                expect(game.is_check_mate?('black')).to be true
            end
        end

        context "Balestra Mate (white)" do
            before do
                game.create_board
                game.board[7][4].piece = King.new('white')
                game.board[5][5].piece = Queen.new('black')
                game.board[5][2].piece = Bishop.new('black')
            end

            it 'returns true' do
                expect(game.is_check_mate?('white')).to be true
            end
        end

        context "Boden's Mate (black)" do
            before do
                game.create_board
                game.board[0][2].piece = King.new('black')
                game.board[0][3].piece = Rook.new('black')
                game.board[1][3].piece = Pawn.new('black')
                game.board[4][5].piece = Bishop.new('white')
                game.board[2][0].piece = Bishop.new('white')
            end

            it 'returns true' do
                expect(game.is_check_mate?('black')).to be true
            end
        end

        context "Boden's Mate (white)" do
            before do
                game.create_board
                game.board[7][2].piece = King.new('white')
                game.board[7][3].piece = Rook.new('white')
                game.board[6][3].piece = Pawn.new('white')
                game.board[3][5].piece = Bishop.new('black')
                game.board[5][0].piece = Bishop.new('black')
            end

            it 'returns true' do
                expect(game.is_check_mate?('white')).to be true
            end
        end

        context "when you can block a checkmate with a piece (1,  black)" do
            before do
                game.create_board
                game.set_pieces
                game.board[3][1].piece = Bishop.new('white')
                game.board[1][3].piece = nil
            end

            it 'returns false' do
                expect(game.is_check_mate?('black')).to be false
            end
        end

        context "when you can block a checkmate with a piece (1, white)" do
            before do
                game.create_board
                game.set_pieces
                game.board[4][1].piece = Bishop.new('black')
                game.board[6][3].piece = nil
            end

            it 'returns false' do
                expect(game.is_check_mate?('white')).to be false
            end
        end

        context "when you can block a checkmate with a piece (2, black)" do
            before do
                game.create_board
                game.board[1][7].piece = King.new('black')
                game.board[1][6].piece = Pawn.new('black')
                game.board[1][5].piece = Bishop.new('black')
                game.board[5][7].piece = Rook.new('white')
                game.board[1][4].piece = Knight.new('white')
            end

            it 'returns true' do
                expect(game.is_check_mate?('black')).to be false
            end
        end

        context "when you can block a checkmate with a piece (2, white)" do
            before do
                game.create_board
                game.board[6][7].piece = King.new('white')
                game.board[6][6].piece = Pawn.new('white')
                game.board[6][5].piece = Bishop.new('white')
                game.board[3][7].piece = Rook.new('black')
                game.board[6][4].piece = Knight.new('black')
            end

            it 'returns true' do
                expect(game.is_check_mate?('white')).to be false
            end
        end

        context "when you can block a checkmate with a piece (3, black)" do
            before do
                game.create_board
                game.board[0][2].piece = King.new('black')
                game.board[0][3].piece = Rook.new('black')
                game.board[0][1].piece = Knight.new('black')
                game.board[1][3].piece = Pawn.new('black')
                game.board[4][5].piece = Bishop.new('white')
                game.board[2][0].piece = Bishop.new('white')
            end

            it 'returns true' do
                expect(game.is_check_mate?('black')).to be false
            end
        end

        context "when you can block a checkmate with a piece (3, white)" do
            before do
                game.create_board
                game.board[7][2].piece = King.new('white')
                game.board[7][3].piece = Rook.new('white')
                game.board[7][0].piece = Queen.new('white')
                game.board[6][3].piece = Pawn.new('white')
                game.board[3][5].piece = Bishop.new('black')
                game.board[5][0].piece = Bishop.new('black')
            end

            it 'returns true' do
                expect(game.is_check_mate?('white')).to be false
            end
        end
    end

end