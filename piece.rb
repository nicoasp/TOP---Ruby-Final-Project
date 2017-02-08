require './square.rb'

class Piece

	attr_accessor :color

	def initialize(color, position)
		@color = color
		@position = position
	end

end