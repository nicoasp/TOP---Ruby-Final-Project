require "game"

describe Game do
	describe "#move_legal?" do
		context "in initial position" do
			it "allows opening moves" do
				expect(subject.move_legal?(:pawn_e2, :e4)).to be_true
			end
		end
	end

end