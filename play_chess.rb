require './lib/game.rb'

def display_board(board, active_player)
	system 'clear'
	if active_player == "white"
		print " 8 " + board.a8.inspect + " " + board.b8.inspect + " " + board.c8.inspect + " " + board.d8.inspect + " " + board.e8.inspect + " " + board.f8.inspect + " " + board.g8.inspect + " " + board.h8.inspect
		puts
		print " 7 " + board.a7.inspect + " " + board.b7.inspect + " " + board.c7.inspect + " " + board.d7.inspect + " " + board.e7.inspect + " " + board.f7.inspect + " " + board.g7.inspect + " " + board.h7.inspect
		puts
		print " 6 " + board.a6.inspect + " " + board.b6.inspect + " " + board.c6.inspect + " " + board.d6.inspect + " " + board.e6.inspect + " " + board.f6.inspect + " " + board.g6.inspect + " " + board.h6.inspect
		puts
		print " 5 " + board.a5.inspect + " " + board.b5.inspect + " " + board.c5.inspect + " " + board.d5.inspect + " " + board.e5.inspect + " " + board.f5.inspect + " " + board.g5.inspect + " " + board.h5.inspect
		puts
		print " 4 " + board.a4.inspect + " " + board.b4.inspect + " " + board.c4.inspect + " " + board.d4.inspect + " " + board.e4.inspect + " " + board.f4.inspect + " " + board.g4.inspect + " " + board.h4.inspect
		puts
		print " 3 " + board.a3.inspect + " " + board.b3.inspect + " " + board.c3.inspect + " " + board.d3.inspect + " " + board.e3.inspect + " " + board.f3.inspect + " " + board.g3.inspect + " " + board.h3.inspect
		puts
		print " 2 " + board.a2.inspect + " " + board.b2.inspect + " " + board.c2.inspect + " " + board.d2.inspect + " " + board.e2.inspect + " " + board.f2.inspect + " " + board.g2.inspect + " " + board.h2.inspect
		puts
		print " 1 " + board.a1.inspect + " " + board.b1.inspect + " " + board.c1.inspect + " " + board.d1.inspect + " " + board.e1.inspect + " " + board.f1.inspect + " " + board.g1.inspect + " " + board.h1.inspect
		puts
		print "   a b c d e f g h"
		puts
	else
		print " 1 " + board.h1.inspect + " " + board.g1.inspect + " " + board.f1.inspect + " " + board.e1.inspect + " " + board.d1.inspect + " " + board.c1.inspect + " " + board.b1.inspect + " " + board.a1.inspect
		puts
		print " 2 " + board.h2.inspect + " " + board.g2.inspect + " " + board.f2.inspect + " " + board.e2.inspect + " " + board.d2.inspect + " " + board.c2.inspect + " " + board.b2.inspect + " " + board.a2.inspect
		puts
		print " 3 " + board.h3.inspect + " " + board.g3.inspect + " " + board.f3.inspect + " " + board.e3.inspect + " " + board.d3.inspect + " " + board.c3.inspect + " " + board.b3.inspect + " " + board.a3.inspect
		puts
		print " 4 " + board.h4.inspect + " " + board.g4.inspect + " " + board.f4.inspect + " " + board.e4.inspect + " " + board.d4.inspect + " " + board.c4.inspect + " " + board.b4.inspect + " " + board.a4.inspect
		puts
		print " 5 " + board.h5.inspect + " " + board.g5.inspect + " " + board.f5.inspect + " " + board.e5.inspect + " " + board.d5.inspect + " " + board.c5.inspect + " " + board.b5.inspect + " " + board.a5.inspect
		puts
		print " 6 " + board.h6.inspect + " " + board.g6.inspect + " " + board.f6.inspect + " " + board.e6.inspect + " " + board.d6.inspect + " " + board.c6.inspect + " " + board.b6.inspect + " " + board.a6.inspect
		puts
		print " 7 " + board.h7.inspect + " " + board.g7.inspect + " " + board.f7.inspect + " " + board.e7.inspect + " " + board.d7.inspect + " " + board.c7.inspect + " " + board.b7.inspect + " " + board.a7.inspect
		puts
		print " 8 " + board.h8.inspect + " " + board.g8.inspect + " " + board.f8.inspect + " " + board.e8.inspect + " " + board.d8.inspect + " " + board.c8.inspect + " " + board.b8.inspect + " " + board.a8.inspect
		puts
		print "   h g f e d c b a"
		puts	
	end		
end	

game = Game.new

until game.game_over?
	display_board(game.board, game.active_player)
	print "Check! " if game.active_player_checked?
	puts "#{game.active_player}'s turn! Type your move:"
	move = gets.chomp
	if game.move_legal?(move)
		game.make_move(move)
	else
		puts game.move_error
		sleep 3
	end
end
sleep 1
if game.check_mate?
	display_board(game.board)
	sleep 1
	puts "#{game.active_player} is check-mated! #{game.passive_player} wins!"
elsif game.stalemate?
	display_board(game.board)
	sleep 1
	puts "#{game.active_player} is stalemated! The game is a tie!"
end
sleep 1
p game.moves_record
sleep 2