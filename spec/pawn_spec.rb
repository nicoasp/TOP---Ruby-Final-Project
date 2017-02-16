require "game"

describe Pawn do
	before(:all) do
		@game = Game.new
		@pawn = @game.pawn_d2
	end
	context "when in starting position" do
		before do
			@pawn.calculate_legal_moves
		end
		it "can advance one or 2 squares" do
			expect(@pawn.possible_moves).to include(@game.board.d3, @game.board.d4)
			expect(@pawn.possible_moves).not_to include(@game.board.d5)
		end
		it "cannot move diagonally without eating" do
			expect(@pawn.possible_moves).not_to include(@game.board.e3)
		end
	end
	context "when out of starting position" do
		before(:all) do
			@pawn.position = @game.board.d4
			@game.board.d2.piece = nil
			@pawn.calculate_legal_moves
		end
		it "can only move forward 1 square" do
			expect(@pawn.possible_moves).to include(@game.board.d5)
			expect(@pawn.possible_moves).not_to include(@game.board.d6)
		end
		context "when piece of same color in front" do
			before do
				@game.board.d5.piece = @game.bishop_c1
				@pawn.calculate_legal_moves
			end
			it "cannot advance" do
				expect(@pawn.possible_moves).not_to include(@game.board.d5)
			end
			context "when enemy piece to eat" do
				before do
					@game.board.e5.piece = @game.pawn_f7
					@pawn.calculate_legal_moves
				end	
				it "can eat it" do
					expect(@pawn.possible_moves).to include(@game.board.e5)
				end
			end		
		end
		context "when piece of opposite color in front" do
			before do
				@game.board.d5.piece = @game.pawn_c7
				@pawn.calculate_legal_moves
			end
			it "cannot advance" do
				expect(@pawn.possible_moves).not_to include(@game.board.d5)
			end
			context "when enemy piece to eat" do
				before do
					@game.board.e5.piece = @game.pawn_f7
					@pawn.calculate_legal_moves
				end	
				it "can eat it" do
					expect(@pawn.possible_moves).to include(@game.board.e5)
				end
			end		
		end
	end

end