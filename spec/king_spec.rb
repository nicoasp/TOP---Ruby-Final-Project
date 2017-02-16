require "game"

describe King do
	before(:all) do
		@game = Game.new
		@king = @game.king_e1
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
			@game.board.d2.piece = nil
			@game.board.e2.piece = nil
			@king.calculate_legal_moves
		end
		it "can move 1 square on diagonal and column" do
			expect(@king.possible_moves).to include(@game.board.d2, @game.board.e2)
			expect(@king.possible_moves).not_to include(@game.board.d3, @game.board.f3)
		end
	end
	context "when enemy piece to eat" do
		before do
			@game.board.d2.piece = @game.pawn_c7
			@king.calculate_legal_moves
		end
		it "can eat it" do
			expect(@king.possible_moves).to include(@game.board.d2)
		end
	end

end