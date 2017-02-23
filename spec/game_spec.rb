require "game"

describe Game do

	describe "#make_move" do
		context "when simple move" do
			before do
				subject.make_move("e4")
			end
			it "updates all relevant data" do
				expect(subject.board.e2.piece).to eql(nil)
				expect(subject.board.e4.piece).to eql(subject.board.pawn_e2)
				expect(subject.board.pawn_e2.position).to eql(subject.board.e4)
				expect(subject.board.black_pieces_array).to include(subject.board.pawn_d7)
			end
		end
		context "when capture" do
			before do
				subject.make_move("e4")
				subject.make_move("d5")
				subject.make_move("exd5")
			end
			it "updates all relevant data" do
				expect(subject.board.e2.piece).to eql(nil)
				expect(subject.board.d7.piece).to eql(nil)
				expect(subject.board.e4.piece).to eql(nil)
				expect(subject.board.d5.piece).to eql(subject.board.pawn_e2)
				expect(subject.board.pawn_e2.position).to eql(subject.board.d5)
			end
			it "eliminates eaten piece" do
				expect(subject.board.pawn_d7.position).to eql(nil)
				expect(subject.board.black_pieces_array).not_to include(subject.board.pawn_d7)
			end

		end
	end


	describe "#move_legal?" do
		context "in initial position" do
			it "allows legal opening moves" do
				expect(subject.move_legal?("e4")).to eql(true)
				expect(subject.move_legal?("Nc3")).to eql(true)
			end
			it "doesn't allow illegal opening moves" do
				expect(subject.move_legal?("e5")).to eql(false)
				expect(subject.move_legal?("Ra4")).to eql(false)
			end
			context "when wrong notation" do
				before do
					subject.move_legal?("Rax")
				end
				it "gets appropriate message" do
					expect(subject.move_error).to eql("Not a valid move notation")
				end
			end
			context "when impossible move" do
				before do
					subject.move_legal?("Qd4")
				end
				it "gets appropriate message" do
					expect(subject.move_error).to eql("No piece can make that move")
				end
			end
		end
		context "when king exposed" do
			before do
				subject.make_move("e4")
				subject.make_move("e5")
				subject.make_move("Bb5")
			end
			it "doesn't allow move that leaves king exposed" do
				expect(subject.move_legal?("d5")).to eql(false)
			end
			context "when illegal move" do
				before do
					subject.move_legal?("d5")
				end				
				it "gets appropriate message" do
					expect(subject.move_error).to eql("Move would leave king exposed")
				end
			end
		end
	end

	describe "#change_active_player" do
		context "when initialized" do
			it "active_player is white" do
				expect(subject.active_player).to eql("white")
			end
		end
		context "one player change works" do
			before do
				subject.change_active_player
			end
			it "active_player is black" do
				expect(subject.active_player).to eql("black")
			end
		end
		context "two player changes work" do
			before do
				subject.change_active_player
				subject.change_active_player
			end
			it "active_player is again white" do
				expect(subject.active_player).to eql("white")
			end
		end
	end

end