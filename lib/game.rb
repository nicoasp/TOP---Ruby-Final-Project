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
	end

	public

	def make_move(standard_notation_move)
		move = Move.new(@board, @active_player, standard_notation_move)
		move.make_move
		change_active_player
		@move_error = nil
		@moves_record << standard_notation_move
	end

	def move_legal?(standard_notation_move)
		move = Move.new(@board, @active_player, standard_notation_move)
		if move.move_legal?
			return true
		else
			@move_error = move.error_type
			return false
		end
	end

	def change_active_player
		if @active_player == "white"
			@active_player = "black"
			@passive_player = "white"
		else
			@active_player = "white"
			@passive_player = "black"
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

	def add_pawn_special_moves
		if @active_player == "white" && @moves_record.last.match(/[a-h]5/)
			# Add legal move to pawns... but it might get overwritten while calculating if next move is legal
		end
	end
end


=begin

	def check?
		@passive_player.pointing_to?(@active_player.king.position)
	end

	def check_mate?
		check && !active_player_can_move?
	end

	def stalemate?
		!check && !active_player_can_move?
	end

	def game_over?
		!active_player_can_move?
	end

	def active_player_can_move?
		@active_player.active_pieces.each do |piece|
			piece.possible_moves.each do |move|
				return true if move_legal?(piece, move)
			end
		end
		false
	end

=end







