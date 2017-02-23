require './lib/piece.rb'

class Knight < Piece

	def initialize(color, position)
		super
		@type = "knight"
		find_symbol
	end

	def calculate_legal_moves
		super(@position.knight_squares)
	end

end


