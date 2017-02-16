require "game"

describe Queen do
	before(:all) do
		@game = Game.new
		@queen = @game.queen_d1
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
			@game.board.d2.piece = nil
			@game.board.e2.piece = nil
			@queen.calculate_legal_moves
		end
		it "can move on diagonal and column eating d7" do
			expect(@queen.possible_moves).to include(@game.board.d2, @game.board.d3, @game.board.d4, @game.board.d5, @game.board.d6, @game.board.d7)
			expect(@queen.possible_moves).to include(@game.board.e2, @game.board.f3, @game.board.g4, @game.board.h5)
			expect(@queen.possible_moves).not_to include(@game.board.d8)
		end
	end
end