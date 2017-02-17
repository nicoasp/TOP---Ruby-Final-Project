require "game"

describe Player do
	before(:all) do
		@game = Game.new
		@player = @game.white_player
	end
	it "contains all white pieces" do
		expect(@player.pieces).to include(@game.pawn_a2, @game.rook_a1, @game.bishop_c1, @game.knight_b1, @game.queen_d1, @game.king_e1)
	end
end