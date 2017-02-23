require './lib/square.rb'

class Piece

	attr_accessor :position, :possible_moves
	attr_reader :color, :type, :symbol, :moves_record

	def initialize(color, position)
		@color = color
		@position = position
		@possible_moves = []
		@type = nil
		@symbol = nil
		@moves_record = []
	end

	def opposite_color
		return "black" if @color == "white"
		"white"
	end


	def add_move(square)
		@possible_moves << square unless square.occupied_by?(@color)
	end

	def add_moves_path(path_array)
		path_array.each do |sq|
			if sq.occupied_by?(@color)
				return
			elsif sq.occupied_by?(opposite_color)
				@possible_moves << sq
				return
			else
				@possible_moves << sq
			end
		end
	end

	def calculate_legal_moves(piece_paths)
		@possible_moves = []
		piece_paths.each do |path|
			if path.is_a?(Array)
				add_moves_path(path)
			else
				add_move(path)
			end
		end
	end

	def inspect
		self.symbol
	end

	def find_symbol
		case @type
		when "pawn"
			@color == "white" ? @symbol = "\u2659" : @symbol = "\u265F"
		when "knight"
			@color == "white" ? @symbol = "\u2658" : @symbol = "\u265E"
		when "bishop"
			@color == "white" ? @symbol = "\u2657" : @symbol = "\u265D"
		when "rook"
			@color == "white" ? @symbol = "\u2656" : @symbol = "\u265C"
		when "queen"
			@color == "white" ? @symbol = "\u2655" : @symbol = "\u265B"
		when "king"
			@color == "white" ? @symbol = "\u2654" : @symbol = "\u265A"
		end
	end



end


# For normal pieces, I need to go through the paths array checking:
	# For single squares, that there is not a piece of same color.
	# For paths:
		# That there is not a piece of same color (stop)
		# That there is not a piece of opposite color (add and then stop)
# For pawns, I need to go through the advancing array checking:
	# For single squares, that there is no piece of either color
	# For paths:
		# That there is not a piece of either color
# For pawns, I need to go through the capturing array, checking:
	# That there is a piece of opposite color.
