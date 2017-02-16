require './lib/square.rb'

# This class creates a board consisting of 64 Square objects 
# populated with the appropriate relationships between them

class Board

	attr_accessor :squares_array, :a1, :a2, :a3, :a4, :a5, :a6, :a7, :a8, :b1, :b2, :b3, :b4, :b5, :b6, :b7, :b8, :c1, :c2, :c3, :c4, :c5, :c6, :c7, :c8, :d1, :d2, :d3, :d4, :d5, :d6, :d7, :d8, :e1, :e2, :e3, :e4, :e5, :e6, :e7, :e8, :f1, :f2, :f3, :f4, :f5, :f6, :f7, :f8, :g1, :g2, :g3, :g4, :g5, :g6, :g7, :g8, :h1, :h2, :h3, :h4, :h5, :h6, :h7, :h8

	def initialize
		@a1 = Square.new("a", 1)
		@a2 = Square.new("a", 2)
		@a3 = Square.new("a", 3)
		@a4 = Square.new("a", 4)
		@a5 = Square.new("a", 5)
		@a6 = Square.new("a", 6)
		@a7 = Square.new("a", 7)
		@a8 = Square.new("a", 8)
		@b1 = Square.new("b", 1)
		@b2 = Square.new("b", 2)
		@b3 = Square.new("b", 3)
		@b4 = Square.new("b", 4)
		@b5 = Square.new("b", 5)
		@b6 = Square.new("b", 6)
		@b7 = Square.new("b", 7)
		@b8 = Square.new("b", 8)
		@c1 = Square.new("c", 1)
		@c2 = Square.new("c", 2)
		@c3 = Square.new("c", 3)
		@c4 = Square.new("c", 4)
		@c5 = Square.new("c", 5)
		@c6 = Square.new("c", 6)
		@c7 = Square.new("c", 7)
		@c8 = Square.new("c", 8)
		@d1 = Square.new("d", 1)
		@d2 = Square.new("d", 2)
		@d3 = Square.new("d", 3)
		@d4 = Square.new("d", 4)
		@d5 = Square.new("d", 5)
		@d6 = Square.new("d", 6)
		@d7 = Square.new("d", 7)
		@d8 = Square.new("d", 8)
		@e1 = Square.new("e", 1)
		@e2 = Square.new("e", 2)
		@e3 = Square.new("e", 3)
		@e4 = Square.new("e", 4)
		@e5 = Square.new("e", 5)
		@e6 = Square.new("e", 6)
		@e7 = Square.new("e", 7)
		@e8 = Square.new("e", 8)
		@f1 = Square.new("f", 1)
		@f2 = Square.new("f", 2)
		@f3 = Square.new("f", 3)
		@f4 = Square.new("f", 4)
		@f5 = Square.new("f", 5)
		@f6 = Square.new("f", 6)
		@f7 = Square.new("f", 7)
		@f8 = Square.new("f", 8)
		@g1 = Square.new("g", 1)
		@g2 = Square.new("g", 2)
		@g3 = Square.new("g", 3)
		@g4 = Square.new("g", 4)
		@g5 = Square.new("g", 5)
		@g6 = Square.new("g", 6)
		@g7 = Square.new("g", 7)
		@g8 = Square.new("g", 8)
		@h1 = Square.new("h", 1)
		@h2 = Square.new("h", 2)
		@h3 = Square.new("h", 3)
		@h4 = Square.new("h", 4)
		@h5 = Square.new("h", 5)
		@h6 = Square.new("h", 6)
		@h7 = Square.new("h", 7)
		@h8 = Square.new("h", 8)
		@squares_array = [@a1, @a2, @a3, @a4, @a5, @a6, @a7, @a8, @b1, @b2, @b3, @b4, @b5, @b6, @b7, @b8, @c1, @c2, @c3, @c4, @c5, @c6, @c7, @c8, @d1, @d2, @d3, @d4, @d5, @d6, @d7, @d8, @e1, @e2, @e3, @e4, @e5, @e6, @e7, @e8, @f1, @f2, @f3, @f4, @f5, @f6, @f7, @f8, @g1, @g2, @g3, @g4, @g5, @g6, @g7, @g8, @h1, @h2, @h3, @h4, @h5, @h6, @h7, @h8]
		calculate_white_pawn_advances
		calculate_black_pawn_advances
		calculate_white_pawn_captures
		calculate_black_pawn_captures
		calculate_knight_squares
		calculate_bishop_paths
		calculate_rook_paths
		calculate_queen_paths
		calculate_king_squares
	end

	def add_square(start_square, condition_l_diff, condition_n_diff, array_to_add)
		@squares_array.each do |square|
			l_diff = start_square.letter_position.ord - square.letter_position.ord
			n_diff = start_square.number_position - square.number_position
			if l_diff == condition_l_diff && n_diff == condition_n_diff
				array_to_add << square
				return square
			end
		end
		false
	end

	def add_path(square, condition_l_diff, condition_n_diff, array_to_add)
		next_square = add_square(square, condition_l_diff, condition_n_diff, array_to_add)
		if next_square
			add_path(next_square, condition_l_diff, condition_n_diff, array_to_add)
		end
	end

	def calculate_bishop_paths
		@squares_array.each do |sq|
			add_path(sq, 1, 1, sq.bishop_paths[0])
			add_path(sq, 1, -1, sq.bishop_paths[1])
			add_path(sq, -1, 1, sq.bishop_paths[2])
			add_path(sq, -1, -1, sq.bishop_paths[3])
		end
	end

	def calculate_knight_squares
		@squares_array.each do |sq|
			add_square(sq, -2, -1, sq.knight_squares)
			add_square(sq, -2, 1, sq.knight_squares)
			add_square(sq, -1, -2, sq.knight_squares)
			add_square(sq, -1, 2, sq.knight_squares)
			add_square(sq, 1, -2, sq.knight_squares)
			add_square(sq, 1, 2, sq.knight_squares)
			add_square(sq, 2, -1, sq.knight_squares)
			add_square(sq, 2, 1, sq.knight_squares)
		end
	end

	def calculate_rook_paths
		@squares_array.each do |sq|
			add_path(sq, 1, 0, sq.rook_paths[0])
			add_path(sq, -1, 0, sq.rook_paths[1])
			add_path(sq, 0, 1, sq.rook_paths[2])
			add_path(sq, 0, -1, sq.rook_paths[3])
		end		
	end

	def calculate_queen_paths
		@squares_array.each do |sq|
			add_path(sq, 1, 1, sq.queen_paths[0])
			add_path(sq, 1, -1, sq.queen_paths[1])
			add_path(sq, -1, 1, sq.queen_paths[2])
			add_path(sq, -1, -1, sq.queen_paths[3])
			add_path(sq, 1, 0, sq.queen_paths[4])
			add_path(sq, -1, 0, sq.queen_paths[5])
			add_path(sq, 0, 1, sq.queen_paths[6])
			add_path(sq, 0, -1, sq.queen_paths[7])			
		end		
	end

	def calculate_king_squares
		@squares_array.each do |sq|
			add_square(sq, 1, 1, sq.king_squares)
			add_square(sq, 1, -1, sq.king_squares)
			add_square(sq, -1, 1, sq.king_squares)
			add_square(sq, -1, -1, sq.king_squares)
			add_square(sq, 1, 0, sq.king_squares)
			add_square(sq, -1, 0, sq.king_squares)
			add_square(sq, 0, 1, sq.king_squares)
			add_square(sq, 0, -1, sq.king_squares)			
		end		
	end

	def calculate_white_pawn_advances
		second_file_squares = @squares_array.select {|sq| sq.number_position == 2}
		second_file_squares.each do |sq|
			sq.white_pawn_advances << []
			first_square = add_square(sq, 0, -1, sq.white_pawn_advances[0])
			add_square(first_square, 0, -1, sq.white_pawn_advances[0])
		end
		third_to_seventh_file = @squares_array.select {|sq| sq.number_position > 2 && sq.number_position < 8 }
		third_to_seventh_file.each do |sq|
			add_square(sq, 0, -1, sq.white_pawn_advances)
		end
	end

	def calculate_black_pawn_advances
		seventh_file_squares = @squares_array.select {|sq| sq.number_position == 7}
		seventh_file_squares.each do |sq|
			sq.black_pawn_advances << []
			first_square = add_square(sq, 0, 1, sq.black_pawn_advances[0])
			add_square(first_square, 0, 1, sq.black_pawn_advances[0])
		end
		second_to_sixth_file = @squares_array.select {|sq| sq.number_position > 1 && sq.number_position < 7 }
		second_to_sixth_file.each do |sq|
			add_square(sq, 0, 1, sq.black_pawn_advances)
		end
	end

	def calculate_white_pawn_captures
		second_to_seventh_file = @squares_array.select {|sq| sq.number_position > 1 && sq.number_position < 8 }
		second_to_seventh_file.each do |sq|
			add_square(sq, 1, -1, sq.white_pawn_captures)
			add_square(sq, -1, -1, sq.white_pawn_captures)
		end
	end

	def calculate_black_pawn_captures
		second_to_seventh_file = @squares_array.select {|sq| sq.number_position > 1 && sq.number_position < 8 }
		second_to_seventh_file.each do |sq|
			add_square(sq, 1, 1, sq.black_pawn_captures)
			add_square(sq, -1, 1, sq.black_pawn_captures)
		end
	end




end




