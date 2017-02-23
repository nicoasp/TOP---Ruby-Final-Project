require './lib/board.rb'

class Move

	attr_accessor :board, :piece_to_move
	attr_reader :temp_board, :valid_notation, :error_type, :player_pieces, :enemy_player_pieces, :standard_notation_move, :piece_type, :eating_move, :specification, :target_position, :target_square, :starting_square, :eaten_piece

	def initialize(board, player, standard_notation_move, en_passant_position = nil)
		@board = board
		@temp_board = Marshal.load(Marshal.dump(@board))
		@player = player
		@player_pieces = nil
		@enemy_player_pieces = nil
		@standard_notation_move = standard_notation_move
		@en_passant_position = en_passant_position
		@en_passant_move = false
		@en_passant_target = ""
		en_passant_target if @en_passant_position
		@piece_type = ""
		@eating_move = false
		@specification = false
		@promotion = false
		@castle_short = false
		@castle_long = false
		@castle_king = nil
		@castle_rook = nil
		@castle_king_target = nil
		@castle_rook_target = nil
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
		if (@castle_short && !castle_short_legal?) || (@castle_long && !castle_long_legal?)
			@error_type = "Cannot castle"
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
		if @promotion
			pawn_promotion
		elsif @castle_short || @castle_long
			king_castle
		elsif @en_passant_move
			en_passant_capture
		else
			eliminate_eaten_piece if @eaten_piece
			@piece_to_move.position = @target_square
			@target_square.piece = @piece_to_move
			@starting_square.piece = nil			
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

	def castle_short_legal?
		@player == "white" ? (@board.king_e1.moves_record.empty? && @board.rook_h1.moves_record.empty? && @board.f1.piece == nil && @board.g1.piece == nil) : (@board.king_e8.moves_record.empty? && @board.rook_h8.moves_record.empty? && @board.f8.piece == nil && @board.g8.piece == nil)
	end

	def castle_long_legal?
		@player == "white" ? (@board.king_e1.moves_record.empty? && @board.rook_a1.moves_record.empty? && @board.b1.piece == nil && @board.c1.piece == nil && @board.d1.piece == nil) : (@board.king_e8.moves_record.empty? && @board.rook_a8.moves_record.empty? && @board.b8.piece == nil && @board.c8.piece == nil && @board.d8.piece == nil)
	end

	def king_castle
		starting_square_king = @castle_king.position
		starting_square_rook = @castle_rook.position
		@castle_king.position = @castle_king_target
		@castle_king_target.piece = @castle_king
		@castle_rook.position = @castle_rook_target
		@castle_rook_target.piece = @castle_rook
		starting_square_king.piece = nil
		starting_square_rook.piece = nil
	end

	def en_passant_capture
		@eaten_piece.position.piece = nil
		eliminate_eaten_piece
		@piece_to_move.position = @target_square
		@target_square.piece = @piece_to_move
		@starting_square.piece = nil
	end


	def eliminate_eaten_piece
		@eaten_piece.position = nil
		@enemy_player_pieces.delete(@eaten_piece)
	end

	def set_up_move(board)
		if @castle_short || @castle_long
			set_up_castle(board)
			return
		elsif @en_passant_move
			set_up_en_passant(board)
			return
		end
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

	def set_up_castle(board)
		if @player == "white"
			@piece_to_move = board.king_e1
			@castle_king = board.king_e1
			if @castle_short
				@castle_rook = board.rook_h1
				@castle_king_target = board.g1
				@castle_rook_target = board.f1
			else
				@castle_rook = board.rook_a1
				@castle_king_target = board.c1
				@castle_rook_target = board.d1
			end				
		else
			@piece_to_move = board.king_e8
			@castle_king = board.king_e8
			if @castle_short
				@castle_rook = board.rook_h8
				@castle_king_target = board.g8
				@castle_rook_target = board.f8
			else
				@castle_rook = board.rook_a8
				@castle_king_target = board.c8
				@castle_rook_target = board.d8
			end
		end
	end

	def set_up_en_passant(board)
		starting_position = en_passant_positions.select {|position| position[0] == @specification}[0]
		@starting_square = board.squares_array.select {|sq| sq.position == starting_position}[0]
		@piece_to_move = @starting_square.piece
		@target_square = board.squares_array.select {|sq| sq.position == @en_passant_target}[0]
		@eaten_piece = board.squares_array.select {|sq| sq.position == @en_passant_position}[0].piece
		@player == "white" ? @player_pieces = board.white_pieces_array : @player_pieces = board.black_pieces_array
		@player == "black" ? @enemy_player_pieces = board.white_pieces_array : @enemy_player_pieces = board.black_pieces_array
	end

	def en_passant_positions
		position1 = "#{(@en_passant_position[0].ord - 1).chr}#{@en_passant_position[1]}"
		position2 = "#{(@en_passant_position[0].ord + 1).chr}#{@en_passant_position[1]}"
		[position1, position2]
	end

	def en_passant_target
		@en_passant_target = "#{@en_passant_position[0]}6" if @en_passant_position[1] == "5"
		@en_passant_target = "#{@en_passant_position[0]}3" if @en_passant_position[1] == "4"
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
			elsif standard_notation_move == "O-O"
				@castle_short = true
				@valid_notation = true
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
			elsif standard_notation_move.match(/[a-h]x[a-h][1-8]/) && (standard_notation_move[0].ord - standard_notation_move[2].ord).abs == 1
				@valid_notation = true
				@eating_move = true
				@specification = @standard_notation_move[0]
				@piece_type = "pawn"
				if @en_passant_position && standard_notation_move[-2, 2] == @en_passant_target
					@en_passant_move = true
				end
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
			elsif standard_notation_move == "O-O-O"
				@castle_long = true
				@valid_notation = true
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








