require './lib/piece.rb'

class King < Piece

	def initialize(color, position)
		super
	end

	def calculate_legal_moves
		super(@position.king_squares)
	end

end