require './piece.rb'

class Pawn < Piece

	attr_accessor :possible_moves

	def initialize(color, position)
		super
		calculate_possible_moves
	end

	def calculate_possible_moves
		if @color == "white"
			@possible_moves = @position.connected_squares_white_pawn
		elsif @color == "black"
			@possible_moves = @position.connected_squares_black_pawn
		end
		@possible_moves
	end

end