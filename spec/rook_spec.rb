require "board"

describe Rook do
	before(:all) do
		@board = Board.new
		@rook = @board.rook_a1
	end
	context "when in starting position" do
		before do
			@rook.calculate_legal_moves
		end
		it "cannot move" do
			expect(@rook.possible_moves).to eql([])
		end
	end
	context "when pawn on a2 gone" do
		before do 
			@board.a2.piece = nil
			@rook.calculate_legal_moves
		end
		it "can move on column and eat a7" do
			expect(@rook.possible_moves).to include(@board.a2, @board.a3, @board.a4, @board.a5, @board.a6, @board.a7)
			expect(@rook.possible_moves).not_to include(@board.a8)
		end
	end
end