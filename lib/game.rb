require './lib/board.rb'
require './lib/player.rb'

class Game

	attr_accessor :board, :white_player, :black_player

	def initialize
		@board = Board.new
		@white_player = Player.new("white")
		@black_player = Player.new("black")
		@active_player = @white_player
		@passive_player = @black_player
		@white_player.active_pieces = @board.white_pieces_array
		@black_player.active_pieces = @board.black_pieces_array
	end

	def check?
		@passive_player.pointing_to?(@active_player.king.position)
	end

	def check_mate?
		check && !active_player_can_move?
	end

	def stalemate?
		!check && !active_player_can_move
	end

	def game_over?
		!active_player_can_move
	end

	def change_active_player
		if @active_player == @white_player
			@active_player = @black_player 
			@passive_player = @white_player
		else
			@active_player = @white_player
			@passive_player = @black_player
		end
	end

	def make_move(piece_to_move, target_square, test = false)
		starting_square = piece_to_move.position
		eliminate_eaten_piece unless test
		# Does not work. I need it to eliminate the piece also on test or it will give false positives on checks
		piece_to_move.position = target_square
		target_square.piece = piece_to_move
		starting_square.piece = nil
	end

	def move_legal?(piece_to_move, target_square)
		return false unless @active_player.active_pieces.include?(piece_to_move)
		piece_to_move.calculate_legal_moves
		return false unless piece_to_move.possible_moves.include?(target_square)
		temp_board = create_temp_board
		make_move(temp_board.piece_to_move, temp_board.target_square, true)
		if @active_player == @white_player
			return false if @passive_player.pointing_to?(temp_board.king_e1.position)
		else
			return false if @passive_player.pointing_to?(temp_board.king_e8.position)
		end
		true
	end

	def eliminate_eaten_piece(target_square)
		target_square.piece.position = nil 
		@passive_player.eaten_pieces << @passive_player.active_pieces.delete(target_square.piece)
	end

	def active_player_can_move?
		@active_player.active_pieces.each do |piece|
			piece.possible_moves.each do |move|
				return true if move_legal?(piece, move)
			end
		end
		false
	end



	private

		def create_temp_board
			Marshal.load(Marshal.dump(@board))
		end


end










