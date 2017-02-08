require './pawn.rb'

class Square

	attr_accessor :letter_position, :number_position, :position, :piece, :connected_squares_white_pawn, :connected_squares_black_pawn, :connected_squares_knight, :connected_squares_bishop, :connected_squares_rook, :connected_squares_queen, :connected_squares_king

	def initialize(letter_position, number_position, piece = nil)
		@letter_position = letter_position
		@number_position = number_position
		@position = "#{@letter_position}#{@number_position}"
		@connected_squares_white_pawn = []
		@connected_squares_black_pawn = []
		@connected_squares_knight = []
		@connected_squares_bishop = []
		@connected_squares_rook = []
		@connected_squares_queen = []
		@connected_squares_king = []
		@piece = piece
	end

end
