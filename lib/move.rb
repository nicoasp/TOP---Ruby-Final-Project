require './lib/board.rb'

class Move

	attr_accessor :board
	attr_reader :temp_board, :valid_notation, :error_type, :player_pieces, :enemy_player_pieces, :standard_notation_move, :piece_type, :eating_move, :specification, :target_position, :target_square, :starting_square, :piece_to_move, :eaten_piece

	def initialize(board, player, standard_notation_move)
		@board = board
		@temp_board = Marshal.load(Marshal.dump(@board))
		@player = player
		@player_pieces = nil
		@enemy_player_pieces = nil
		@standard_notation_move = standard_notation_move
		@piece_type = ""
		@eating_move = false
		@specification = false
		@promotion = false
		@valid_notation = false
		@error_type = ""
		@target_position = ""
		parse_notation
		@starting_square = nil
		@target_square = nil
		@piece_to_move = nil
		@eaten_piece = nil
	end

	public

	def make_move
		set_up_move(@board)
		make_move_internal
	end

	def move_legal?
		return false unless @valid_notation
		set_up_move(@temp_board)
		if @piece_to_move.nil?
			@error_type = "No piece can make that move" if @error_type.empty?
			return false
		end
		make_move_internal
		if (@player == "white" && temp_board.white_king_checked?) || (@player == "black" && temp_board.black_king_checked?)
			@error_type = "Move would leave king exposed"
			return false
		end
		true
	end


	private

	def make_move_internal
		if !@promotion
			eliminate_eaten_piece if @eaten_piece
			@piece_to_move.position = @target_square
			@target_square.piece = @piece_to_move
			@starting_square.piece = nil
		else
			pawn_promotion
		end
	end

	def pawn_promotion
		new_queen = Queen.new(@player, @target_square)
		@piece_to_move.position = nil
		@starting_square.piece = nil
		@player_pieces.delete(@piece_to_move)
		@player_pieces << new_queen
		@target_square.piece = new_queen
	end

	def eliminate_eaten_piece
		@eaten_piece.position = nil
		@enemy_player_pieces.delete(@eaten_piece)
	end

	def set_up_move(board)
		@target_square = board.squares_array.select {|sq| sq.position == @target_position}[0]
		@player == "white" ? @player_pieces = board.white_pieces_array : @player_pieces = board.black_pieces_array
		@player == "black" ? @enemy_player_pieces = board.white_pieces_array : @enemy_player_pieces = board.black_pieces_array
		possible_pieces = []
		@player_pieces.each do |piece|
			if piece.type == @piece_type
				piece.calculate_legal_moves
				if piece.possible_moves.include?(@target_square)
					possible_pieces << piece
				end
			end
		end
		case possible_pieces.size
		when 1
			@piece_to_move = possible_pieces[0]
		when 2
			if @specification
				@piece_to_move = possible_pieces.select {|p| ((p.position.letter_position == @specification) || (p.position.number_position == @specification))}[0]
			else
				@error_type = "Two different pieces can make that move"
			end
		end
		if @piece_to_move
			@starting_square = @piece_to_move.position
			@eaten_piece = @target_square.piece unless @target_square.piece.nil?
		end
	end

	def parse_notation
		case standard_notation_move.length
		when 2
			if standard_notation_move.match(/[a-h][1-8]/)
				@valid_notation = true
				@piece_type = "pawn"
			end
		when 3
			if standard_notation_move.match(/[BNRQK][a-h][1-8]/)
				@valid_notation = true
				case standard_notation_move[0]
				when "B"
					@piece_type = "bishop"
				when "N"
					@piece_type = "knight"
				when "R"
					@piece_type = "rook"
				when "Q"
					@piece_type = "queen"
				when "K"
					@piece_type = "king"
				end
			end
		when 4
			if standard_notation_move.match(/[BNRQK]x[a-h][1-8]/)
				@valid_notation = true
				@eating_move = true
				case standard_notation_move[0]
				when "B"
					@piece_type = "bishop"
				when "N"
					@piece_type = "knight"
				when "R"
					@piece_type = "rook"
				when "Q"
					@piece_type = "queen"
				when "K"
					@piece_type = "king"
				end
			elsif standard_notation_move.match(/[a-h]x[a-h][1-8]/)
				@valid_notation = true
				@eating_move = true
				@specification = @standard_notation_move[0]
				@piece_type = "pawn"
			elsif standard_notation_move.match(/[BNRQK][a-h1-8][a-h][1-8]/)
				@valid_notation = true
				@specification = standard_notation_move[1]
				case standard_notation_move[0]
				when "B"
					@piece_type = "bishop"
				when "N"
					@piece_type = "knight"
				when "R"
					@piece_type = "rook"
				when "Q"
					@piece_type = "queen"
				when "K"
					@piece_type = "king"
				end
			end
		when 5
			if standard_notation_move.match(/[BNRQK][a-h1-8]x[a-h][1-8]/)
				@valid_notation = true
				@eating_move = true
				@specification = standard_notation_move[1]
				case standard_notation_move[0]
				when "B"
					@piece_type = "bishop"
				when "N"
					@piece_type = "knight"
				when "R"
					@piece_type = "rook"
				when "Q"
					@piece_type = "queen"
				when "K"
					@piece_type = "king"
				end
			end
		end
		if @valid_notation
			@target_position = standard_notation_move[-2, 2]
			if @piece_type == "pawn" && standard_notation_move[-1] == "1" || standard_notation_move[-1] == "8"
				@promotion = true
			end
		else
			@error_type = "Not a valid move notation"
		end
	end

	attr_reader :standard_notation_move
end








