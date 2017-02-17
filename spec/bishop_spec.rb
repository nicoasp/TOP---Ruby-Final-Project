require "board"

describe Bishop do
	before(:all) do
		@board = Board.new
		@bishop = @board.bishop_c1
	end
	context "when in starting position" do
		before do
			@bishop.calculate_legal_moves
		end
		it "cannot move" do
			expect(@bishop.possible_moves).to eql([])
		end
	end
	context "when diagonal open" do
		before do 
			@board.d2.piece = nil
			@bishop.calculate_legal_moves
		end
		it "can move on diagonal" do
			expect(@bishop.possible_moves).to include(@board.d2, @board.e3, @board.f4, @board.g5, @board.h6)
			expect(@bishop.possible_moves).not_to include(@board.b2)
		end
	end
	context "when enemy piece to eat" do
		before do
			@board.d2.piece = nil
			@board.f4.piece = @board.pawn_f7
			@bishop.calculate_legal_moves
		end
		it "can eat piece but not go further" do
			expect(@bishop.possible_moves).to include(@board.d2, @board.e3, @board.f4)
			expect(@bishop.possible_moves).not_to include(@board.g5, @board.h6)
		end
	end
end