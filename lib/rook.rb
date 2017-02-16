require './lib/piece.rb'

class Rook < Piece

	def initialize(color, position)
		super
	end

	def calculate_legal_moves
		super(@position.rook_paths)
	end

end