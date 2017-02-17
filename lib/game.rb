require './lib/board.rb'
require './lib/player.rb'

class Game

	attr_accessor :board, :white_player, :black_player

	def initialize
		@board = Board.new
		@white_player = Player.new("white")
		@black_player = Player.new("black")
		@active_player = @white_player
		@white_player.pieces = @board.white_pieces_array
		@black_player.pieces = @board.black_pieces_array
	end

	def white_king_checked?
		@black_player.pointing_to?(@board.king_e1.position)
	end

	def black_king_checked?
		@white_player.pointing_to?(@board.king_e8.position)
	end

	def change_active_player
		@active_player = @black_player if @active_player == @white_player
		@active_player = @white_player
	end

	def create_temp_board
		Marshal.load(Marshal.dump(@board))
	end
		
	# This method needs to be reworked:
	def make_move_if_legal(piece_to_move, target_square)
		# Checks if the piece you want to move is yours
		return false unless @active_player.pieces.include?(piece_to_move)
		piece_to_move.calculate_legal_moves
		# Checks if the square you want to go is in reach of the piece
		return false unless piece_to_move.possible_moves.include?(target_square)
		# Makes the move (updates all relevant data)
		starting_square = piece_to_move.position
		unless target_square.piece == nil
			eaten_piece = target_square.piece 
			eaten_piece.position = nil
		end
		piece_to_move.position = target_square
		target_square.piece = piece_to_move
		starting_square.piece = nil
		# Checks if the move caused your king to be exposed
		if piece_to_move.color == "white"
			exposed_king = white_king_checked?
		else
			exposed_king = black_king_checked?
		end
		# If the king was exposed by the move, it unmakes it
		if exposed_king
			starting_square.piece = piece_to_move
			piece_to_move.position = starting_square
			if eaten_piece
				target_square.piece = eaten_piece
				eaten_piece.position = target_square
			else
				target_square.piece = nil
			end
			return false
		end
		true
	end


end










