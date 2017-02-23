require './lib/board.rb'
require './lib/move.rb'
require './lib/move_translator.rb'
#require './lib/player.rb'

class Game

	attr_accessor :board
	attr_reader :active_player, :passive_player, :move_error, :moves_record

	def initialize
		@board = Board.new
		@active_player = "white"
		@passive_player = "black"
		@move_error = nil
		@moves_record = []
		@en_passant_position = nil
	end

	public

	def make_move(standard_notation_move)
		if en_passant_possible?
			move = Move.new(@board, @active_player, standard_notation_move, @en_passant_position)
		else
			move = Move.new(@board, @active_player, standard_notation_move)
		end
		move.make_move
		change_active_player
		@move_error = nil
		@moves_record << standard_notation_move
		move.piece_to_move.moves_record << standard_notation_move
		@en_passant_position = nil
	end

	def move_legal?(standard_notation_move)
		if en_passant_possible?
			move = Move.new(@board, @active_player, standard_notation_move, @en_passant_position)
		else
			move = Move.new(@board, @active_player, standard_notation_move)
		end
		if move.move_legal?
			return true
		else
			@move_error = move.error_type
			return false
		end
	end

	def game_over?
		@active_player == "white" ? active_pieces = @board.white_pieces_array : active_pieces = @board.black_pieces_array
		active_pieces.each do |active_piece|
			active_piece.calculate_legal_moves
			active_piece.possible_moves.each do |possible_move|
				return false if move_legal?(MoveTranslator.new(active_piece.type, active_piece.position.position, possible_move.position, !possible_move.piece.nil?).standard_notation_move)
			end
		end
		true
	end

	def active_player_checked?
		@active_player == "white" ? @board.white_king_checked? : @board.black_king_checked?
	end

	def check_mate?
		game_over? && active_player_checked?
	end

	def stalemate?
		game_over? && !active_player_checked?
	end

	private

	def change_active_player
		if @active_player == "white"
			@active_player = "black"
			@passive_player = "white"
		else
			@active_player = "white"
			@passive_player = "black"
		end
	end

	def en_passant_possible?
		return false if @moves_record.empty?
		last_move = @moves_record.last
		if last_move.length == 2 && last_move.match(/[a-h][45]/)
			pawn_moved = @board.squares_array.select {|sq| sq.position == last_move}[0].piece
			if pawn_moved.moves_record.size == 1
				@en_passant_position = last_move
				positions_to_check = en_passant_positions
				squares_to_check = @board.squares_array.select {|sq| positions_to_check.include?(sq.position)}
				squares_to_check.each {|sq| return true if (sq.occupied_by?(@active_player) && sq.piece.type == "pawn")}
			end
		end
		false
	end

	def en_passant_positions
		position1 = "#{(@en_passant_position[0].ord - 1).chr}#{@en_passant_position[1]}"
		position2 = "#{(@en_passant_position[0].ord + 1).chr}#{@en_passant_position[1]}"
		[position1, position2]
	end
end





