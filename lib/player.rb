require './lib/pawn.rb'
require './lib/knight.rb'
require './lib/bishop.rb'
require './lib/rook.rb'
require './lib/queen.rb'
require './lib/king.rb'

class Player

	attr_accessor :active_pieces, :eaten_pieces
	attr_reader :color

	def initialize(color)
		@color = color
		@active_pieces = []
		@eaten_pieces = []
	end

	def pointing_to(square, pieces = @active_pieces)
		pieces.each do |piece|
			piece.calculate_legal_moves
			piece.possible_moves.each do |sq|
				return true if sq == square
			end
		end
		false
	end

	def king
		@active_pieces.each do |piece|
			return piece if piece.is_a?(King)
		end
	end

end
