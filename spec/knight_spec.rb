require "board"

describe Knight do
	before(:all) do
		@board = Board.new
		@knight = @board.knight_b1
	end
	context "when in starting position" do
		before do
			@knight.calculate_legal_moves
		end
		it "can move out past the pawns" do
			expect(@knight.possible_moves).to include(@board.a3, @board.c3)
			expect(@knight.possible_moves).not_to include(@board.d2)
		end
	end
	context "when enemy piece to eat" do
		before do
			@board.c3.piece = @board.pawn_c7
			@knight.calculate_legal_moves
		end
		it "can eat it" do
			expect(@knight.possible_moves).to include(@board.a3, @board.c3)
			expect(@knight.possible_moves).not_to include(@board.d2)
		end	
	end	
end