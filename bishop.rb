require './piece.rb'

class Bishop < Piece

	def initialize(color, position)
		super
		possible_moves
	end

	def possible_moves
		@possible_moves = @position.connected_squares_bishop
	end

end