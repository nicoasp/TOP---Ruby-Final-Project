require './lib/piece.rb'

class Queen < Piece

	def initialize(color, position)
		super

	end

	def calculate_legal_moves
		super(@position.queen_paths)
	end

end