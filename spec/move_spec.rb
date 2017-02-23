require "move"
require "board"

describe Move do

	describe "#parse_notation" do
		context "when given valid move" do
			it "recognizes valid pawn move" do
				expect(Move.new(Board.new, "white", "e4").valid_notation).to eql(true)
			end
			it "recognizes valid piece moves" do
				expect(Move.new(Board.new, "white", "Ne4").valid_notation).to eql(true)
				expect(Move.new(Board.new, "white", "Qa2").valid_notation).to eql(true)
				expect(Move.new(Board.new, "black", "Bh8").valid_notation).to eql(true)
			end
			it "recognizes valid capture by pawn" do
				expect(Move.new(Board.new, "white", "exf4").valid_notation).to eql(true)
			end
			it "recognizes valid capture by piece" do
				expect(Move.new(Board.new, "white", "Rxc4").valid_notation).to eql(true)
			end
			it "recognizes valid piece move with specification" do
				expect(Move.new(Board.new, "white", "Nde4").valid_notation).to eql(true)
				expect(Move.new(Board.new, "white", "R5h3").valid_notation).to eql(true)
			end
			it "recognizes valid piece capture with specification" do
				expect(Move.new(Board.new, "white", "Ndxe4").valid_notation).to eql(true)
				expect(Move.new(Board.new, "white", "R5xh3").valid_notation).to eql(true)
			end

		end
		context "when given non-valid move" do
			it "recognizes random bad input" do
				expect(Move.new(Board.new, "white", "d").valid_notation).to eql(false)
				expect(Move.new(Board.new, "white", "Tey87c").valid_notation).to eql(false)
			end
			it "recognizes wrong pawn move" do
				expect(Move.new(Board.new, "white", "e9").valid_notation).to eql(false)
			end
			it "recognizes wrong piece moves" do
				expect(Move.new(Board.new, "white", "Ns4").valid_notation).to eql(false)
				expect(Move.new(Board.new, "white", "Ta2").valid_notation).to eql(false)
				expect(Move.new(Board.new, "black", "Bh9").valid_notation).to eql(false)
			end
			it "recognizes wrong capture by pawn" do
				expect(Move.new(Board.new, "black", "exn4").valid_notation).to eql(false)
			end
			it "recognizes wrong capture by piece" do
				expect(Move.new(Board.new, "white", "Rxc").valid_notation).to eql(false)
			end
			it "recognizes wrong piece move with specification" do
				expect(Move.new(Board.new, "white", "Nne4").valid_notation).to eql(false)
				expect(Move.new(Board.new, "white", "R5h").valid_notation).to eql(false)
			end
			it "recognizes wrong piece capture with specification" do
				expect(Move.new(Board.new, "white", "Njxe4").valid_notation).to eql(false)
				expect(Move.new(Board.new, "white", "R5xh9").valid_notation).to eql(false)
			end
		end
	end
end