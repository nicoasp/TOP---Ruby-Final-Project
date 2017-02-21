require './lib/board.rb'
#require './lib/player.rb'

class Game

	attr_accessor :board, #:white_player, :black_player

	def initialize
		@board = Board.new
		#@white_player = Player.new("white")
		#@black_player = Player.new("black")
		#@active_player = @white_player
		#@passive_player = @black_player
		#@white_player.active_pieces = @board.white_pieces_array
		#@black_player.active_pieces = @board.black_pieces_array
	end




	def move_legal?(piece_to_move, target_square)
		temp_board = create_temp_board
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

	def change_active_player
		if @active_player == @white_player
			@active_player = @black_player 
			@passive_player = @white_player
		else
			@active_player = @white_player
			@passive_player = @black_player
		end
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



	private

	def create_temp_board
		Marshal.load(Marshal.dump(@board))
	end


end










