require "game"

describe Rook do
	before(:all) do
		@game = Game.new
		@rook = @game.rook_a1
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
			@game.board.a2.piece = nil
			@rook.calculate_legal_moves
		end
		it "can move on column and eat a7" do
			expect(@rook.possible_moves).to include(@game.board.a2, @game.board.a3, @game.board.a4, @game.board.a5, @game.board.a6, @game.board.a7)
			expect(@rook.possible_moves).not_to include(@game.board.a8)
		end
	end
end