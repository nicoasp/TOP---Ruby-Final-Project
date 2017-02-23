class MoveTranslator
	attr_reader :standard_notation_move

	def initialize(piece_type, starting_position, end_position, capture = false)
		@piece_type = piece_type
		@starting_position = starting_position
		@end_position = end_position
		@capture = capture
		@standard_notation_move = ""
		find_standard_notation
	end

	def find_standard_notation
		case @piece_type
		when "knight"
			@standard_notation_move += "N"
		when "bishop"
			@standard_notation_move += "B"
		when "rook"
			@standard_notation_move += "R"
		when "queen"
			@standard_notation_move += "Q"
		when "king"
			@standard_notation_move += "K"
		when "pawn"
			@standard_notation_move += @starting_position[0] if @capture
		end
		@standard_notation_move += "x" if @capture
		@standard_notation_move += @end_position
	end
end
