require './lib/pawn.rb'
require './lib/knight.rb'
require './lib/bishop.rb'
require './lib/rook.rb'
require './lib/queen.rb'
require './lib/king.rb'

class Player

	attr_accessor :pieces
	attr_reader :color

	def initialize(color)
		@color = color
		@pieces = []
	end

	def pointing_to(square)
		@pieces.each do |piece|
			piece.calculate_legal_moves
			piece.possible_moves.each do |sq|
				return true if sq == square
			end
		end
		false
	end

end
