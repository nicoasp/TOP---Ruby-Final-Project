require './lib/piece.rb'

class Bishop < Piece

	def initialize(color, position)
		super
	end

	def calculate_legal_moves
		super(@position.bishop_paths)
	end

end