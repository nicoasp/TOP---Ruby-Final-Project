class Square

	attr_accessor :symbol, :bishop_paths, :knight_squares, :rook_paths, :queen_paths, :king_squares, :white_pawn_advances, :white_pawn_captures, :black_pawn_advances, :black_pawn_captures, :letter_position, :number_position, :position, :piece

	def initialize(letter_position, number_position, symbol = "\u2B1C")
		@letter_position = letter_position
		@number_position = number_position
		@position = "#{@letter_position}#{@number_position}"
		@piece = nil
		@bishop_paths = [[], [], [], []]
		@knight_squares = []
		@rook_paths = [[], [], [], []]
		@queen_paths = [[], [], [], [], [], [], [], []]
		@king_squares = []
		@white_pawn_advances = []
		@white_pawn_captures = []
		@black_pawn_advances = []
		@black_pawn_captures = []
		@symbol = symbol
	end


	def occupied_by?(color = nil)
		return @piece != nil unless color
		@piece != nil && @piece.color == color
	end

	def inspect
		if self.piece.nil?
			self.symbol
		else
			self.piece.inspect
		end
	end

end
