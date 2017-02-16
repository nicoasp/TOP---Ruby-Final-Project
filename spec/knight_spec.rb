require "game"

describe Knight do
	before(:all) do
		@game = Game.new
		@knight = @game.knight_b1
	end
	context "when in starting position" do
		before do
			@knight.calculate_legal_moves
		end
		it "can move out past the pawns" do
			expect(@knight.possible_moves).to include(@game.board.a3, @game.board.c3)
			expect(@knight.possible_moves).not_to include(@game.board.d2)
		end
	end
	context "when enemy piece to eat" do
		before do
			@game.board.c3.piece = @game.pawn_c7
			@knight.calculate_legal_moves
		end
		it "can eat it" do
			expect(@knight.possible_moves).to include(@game.board.a3, @game.board.c3)
			expect(@knight.possible_moves).not_to include(@game.board.d2)
		end	
	end	
end