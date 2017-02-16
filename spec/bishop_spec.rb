require "game"

describe Bishop do
	before(:all) do
		@game = Game.new
		@bishop = @game.bishop_c1
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
			@game.board.d2.piece = nil
			@bishop.calculate_legal_moves
		end
		it "can move on diagonal" do
			expect(@bishop.possible_moves).to include(@game.board.d2, @game.board.e3, @game.board.f4, @game.board.g5, @game.board.h6)
			expect(@bishop.possible_moves).not_to include(@game.board.b2)
		end
	end
	context "when enemy piece to eat" do
		before do
			@game.board.d2.piece = nil
			@game.board.f4.piece = @game.pawn_f7
			@bishop.calculate_legal_moves
		end
		it "can eat piece but not go further" do
			expect(@bishop.possible_moves).to include(@game.board.d2, @game.board.e3, @game.board.f4)
			expect(@bishop.possible_moves).not_to include(@game.board.g5, @game.board.h6)
		end
	end
end