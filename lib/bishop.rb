require './lib/piece.rb'

class Bishop < Piece

	def initialize(color, position)
		super
		@type = "bishop"
		find_symbol
	end

	def calculate_legal_moves
		super(@position.bishop_paths)
	end

end
