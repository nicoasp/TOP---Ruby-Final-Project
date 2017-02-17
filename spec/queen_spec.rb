require "board"

describe Queen do
	before(:all) do
		@board = Board.new
		@queen = @board.queen_d1
	end
	context "when in starting position" do
		before do
			@queen.calculate_legal_moves
		end
		it "cannot move" do
			expect(@queen.possible_moves).to eql([])
		end
	end
	context "when pawns on d2 and e2 gone" do
		before do 
			@board.d2.piece = nil
			@board.e2.piece = nil
			@queen.calculate_legal_moves
		end
		it "can move on diagonal and column eating d7" do
			expect(@queen.possible_moves).to include(@board.d2, @board.d3, @board.d4, @board.d5, @board.d6, @board.d7)
			expect(@queen.possible_moves).to include(@board.e2, @board.f3, @board.g4, @board.h5)
			expect(@queen.possible_moves).not_to include(@board.d8)
		end
	end
end