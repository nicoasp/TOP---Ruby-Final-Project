require './square.rb'

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
		calculate_connected_squares_white_pawn
		calculate_connected_squares_black_pawn
		calculate_connected_squares_knight
		calculate_connected_squares_bishop
		calculate_connected_squares_rook
		calculate_connected_squares_queen
		calculate_connected_squares_king
	end

	def calculate_connected_squares_white_pawn
		@squares_array.each do |square1|
			@squares_array.each do |square2|
				l_diff = square1.letter_position.ord - square2.letter_position.ord
				n_diff = square1.number_position - square2.number_position
				if (l_diff == 0 && n_diff == 1) || (square2.number_position == 2 && (l_diff == 0 && n_diff == 2))		
					square2.connected_squares_white_pawn << square1 unless square2.connected_squares_white_pawn.include?(square1)
				end
			end
		end
	end

	def calculate_connected_squares_black_pawn
		@squares_array.each do |square1|
			@squares_array.each do |square2|
				l_diff = square1.letter_position.ord - square2.letter_position.ord
				n_diff = square1.number_position - square2.number_position
				if (l_diff == 0 && n_diff == 1) || (square1.number_position == 7 && (l_diff == 0 && n_diff == 2))	
					square1.connected_squares_black_pawn << square2 unless square1.connected_squares_black_pawn.include?(square2)
				end
			end
		end
	end			

	def calculate_connected_squares_knight
		@squares_array.each do |square1|
			@squares_array.each do |square2|
				l_diff = square1.letter_position.ord - square2.letter_position.ord
				n_diff = square1.number_position - square2.number_position
				if ((l_diff == 2 || l_diff == -2) && (n_diff == 1 || n_diff == -1)) || ((l_diff == 1 || l_diff == -1) && (n_diff == 2 || n_diff == -2))
					square1.connected_squares_knight << square2 unless square1.connected_squares_knight.include?(square2)
					square2.connected_squares_knight << square1 unless square2.connected_squares_knight.include?(square1)
				end
			end
		end
	end

	def calculate_connected_squares_bishop
		@squares_array.each do |square1|
			@squares_array.each do |square2|
				l_diff = square1.letter_position.ord - square2.letter_position.ord
				n_diff = square1.number_position - square2.number_position
				if (l_diff.abs == n_diff.abs) && (l_diff != 0)
					square1.connected_squares_bishop << square2 unless square1.connected_squares_bishop.include?(square2)
					square2.connected_squares_bishop << square1 unless square2.connected_squares_bishop.include?(square1)
				end
			end
		end
	end

	def calculate_connected_squares_rook
		@squares_array.each do |square1|
			@squares_array.each do |square2|
				l_diff = square1.letter_position.ord - square2.letter_position.ord
				n_diff = square1.number_position - square2.number_position
				if (l_diff == 0 || n_diff == 0) && !(l_diff == 0 && n_diff == 0)
					square1.connected_squares_rook << square2 unless square1.connected_squares_rook.include?(square2)
					square2.connected_squares_rook << square1 unless square2.connected_squares_rook.include?(square1)
				end
			end
		end
	end	

	def calculate_connected_squares_queen
		@squares_array.each do |square|
			square.connected_squares_queen = square.connected_squares_rook + square.connected_squares_bishop
		end
	end

	def calculate_connected_squares_king
		@squares_array.each do |square1|
			@squares_array.each do |square2|
				l_diff = square1.letter_position.ord - square2.letter_position.ord
				n_diff = square1.number_position - square2.number_position
				if (l_diff.abs == 1 || n_diff.abs == 1) && l_diff.abs < 2 && n_diff.abs < 2
					square1.connected_squares_king << square2 unless square1.connected_squares_king.include?(square2)
					square2.connected_squares_king << square1 unless square2.connected_squares_king.include?(square1)
				end
			end
		end
	end		

end




