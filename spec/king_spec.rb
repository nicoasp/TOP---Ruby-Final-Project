require "board"

describe King do
	before(:all) do
		@board = Board.new
		@king = @board.king_e1
	end
	context "when in starting position" do
		before do
			@king.calculate_legal_moves
		end
		it "cannot move" do
			expect(@king.possible_moves).to eql([])
		end
	end
	context "when pawns on d2 and e2 gone" do
		before do 
			@board.d2.piece = nil
			@board.e2.piece = nil
			@king.calculate_legal_moves
		end
		it "can move 1 square on diagonal and column" do
			expect(@king.possible_moves).to include(@board.d2, @board.e2)
			expect(@king.possible_moves).not_to include(@board.d3, @board.f3)
		end
	end
	context "when enemy piece to eat" do
		before do
			@board.d2.piece = @board.pawn_c7
			@king.calculate_legal_moves
		end
		it "can eat it" do
			expect(@king.possible_moves).to include(@board.d2)
		end
	end

end