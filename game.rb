require './square.rb'
require './board.rb'
require './pawn.rb'
require './knight.rb'
require './bishop.rb'
require './rook.rb'
require './queen.rb'
require './king.rb'

class Game

	attr_accessor :board

	def initialize
		@board = Board.new
		@pawn_a2 = Pawn.new("white", @board.a2)
		@board.a2.piece = @pawn_a2
		@pawn_b2 = Pawn.new("white", @board.b2)
		@board.b2.piece = @pawn_b2
		@pawn_c2 = Pawn.new("white", @board.c2)
		@board.c2.piece = @pawn_c2
		@pawn_d2 = Pawn.new("white", @board.d2)
		@board.d2.piece = @pawn_d2	
		@pawn_e2 = Pawn.new("white", @board.e2)
		@board.e2.piece = @pawn_e2
		@pawn_f2 = Pawn.new("white", @board.f2)
		@board.f2.piece = @pawn_f2
		@pawn_g2 = Pawn.new("white", @board.g2)
		@board.g2.piece = @pawn_g2
		@pawn_h2 = Pawn.new("white", @board.h2)
		@board.h2.piece = @pawn_h2		
		@pawn_a7 = Pawn.new("black", @board.a7)
		@board.a7.piece = @pawn_a7
		@pawn_b7 = Pawn.new("black", @board.b7)
		@board.b7.piece = @pawn_b7
		@pawn_c7 = Pawn.new("black", @board.c7)
		@board.c7.piece = @pawn_c7
		@pawn_d7 = Pawn.new("black", @board.d7)
		@board.d7.piece = @pawn_d7	
		@pawn_e7 = Pawn.new("black", @board.e7)
		@board.e7.piece = @pawn_e7
		@pawn_f7 = Pawn.new("black", @board.f7)
		@board.f7.piece = @pawn_f7
		@pawn_g7 = Pawn.new("black", @board.g7)
		@board.g7.piece = @pawn_g7
		@pawn_h7 = Pawn.new("black", @board.h7)
		@board.h7.piece = @pawn_h7	
		@knight_b1 = Knight.new("white", @board.b1)
		@board.b1.piece = @knight_b1
		@knight_g1 = Knight.new("white", @board.g1)
		@board.g1.piece = @knight_g1
		@knight_b8 = Knight.new("black", @board.b8)
		@board.b8.piece = @knight_b8
		@knight_g8 = Knight.new("black", @board.g8)
		@board.g8.piece = @knight_g8
		@bishop_c1 = Bishop.new("white", @board.c1)
		@board.c1.piece = @bishop_c1
		@bishop_f1 = Bishop.new("white", @board.f1)
		@board.f1.piece = @bishop_f1
		@bishop_c8 = Bishop.new("black", @board.c8)
		@board.c8.piece = @bishop_c8
		@bishop_f8 = Bishop.new("black", @board.f8)
		@board.f8.piece = @bishop_f8
		@rook_a1 = Rook.new("white", @board.a1)
		@board.a1.piece = @rook_a1
		@rook_h1 = Rook.new("white", @board.h1)
		@board.h1.piece = @rook_h1
		@rook_a8 = Rook.new("black", @board.a8)
		@board.a8.piece = @rook_a8
		@rook_h8 = Rook.new("black", @board.h8)
		@board.h8.piece = @rook_h8
		@queen_d1 = Queen.new("white", @board.d1)
		@board.d1.piece = @queen_d1
		@queen_d8 = Queen.new("black", @board.d8)
		@board.d8.piece = @queen_d8
		@king_e1 = King.new("white", @board.e1)
		@board.e1.piece = @king_e1
		@king_e8 = King.new("black", @board.e8)
		@board.e8.piece = @king_e8
	end

end




