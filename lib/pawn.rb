require './lib/piece.rb'

class Pawn < Piece

	attr_accessor :possible_moves

	def initialize(color, position)
		super
		@type = "pawn"
		find_symbol
	end

	def calculate_legal_moves
		@possible_moves = []
		if color == "white"
			calculate_advances(@position.white_pawn_advances)
			calculate_captures(@position.white_pawn_captures)
		else
			calculate_advances(@position.black_pawn_advances)
			calculate_captures(@position.black_pawn_captures)
		end
	end


	def add_move(square)
		@possible_moves << square unless (square.occupied_by?(@color) || square.occupied_by?(opposite_color))
	end

	def add_moves_path(path_array)
		path_array.each do |sq|
			if sq.occupied_by?(@color) || sq.occupied_by?(opposite_color)
				return
			else
				@possible_moves << sq
			end
		end
	end

	def calculate_advances(paths)
		paths.each do |path|
			if path.is_a?(Array)
				add_moves_path(path)
			else
				add_move(path)
			end
		end
	end

	def calculate_captures(paths)
		paths.each do |sq|
			@possible_moves << sq if sq.occupied_by?(opposite_color)
		end
	end

end