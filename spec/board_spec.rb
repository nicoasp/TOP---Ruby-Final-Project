require "board"

describe Board do

	describe "#make_move" do
		context "in opening position" do
			before do
				subject.make_move(subject.pawn_e2, subject.e4)
			end
			it "makes opening moves correctly" do
				expect(subject.pawn_e2.position).to eql(subject.e4)
				expect(subject.e4.piece).to eql(subject.pawn_e2)
				expect(subject.e2.piece).to be_nil
			end
		end
		context "when eating piece" do
			before do
				subject.make_move(subject.pawn_e2, subject.e4)
				subject.make_move(subject.knight_g8, subject.f6)
				subject.make_move(subject.knight_g8, subject.e4)
			end
			it "makes move correctly" do
				expect(subject.pawn_e2.position).to be_nil
				expect(subject.e4.piece).to eql(subject.knight_g8)
				expect(subject.knight_g8.position).to eql(subject.e4)
			end
			it "eliminates eaten piece" do
				expect(subject.white_pieces_array).not_to include(subject.pawn_e2)
			end
		end
				
	end

	describe "#calculate_bishop_paths" do
		it "calculates right paths for a1" do
			expect(subject.a1.bishop_paths).to include([subject.b2, subject.c3, subject.d4, subject.e5, subject.f6, subject.g7, subject.h8])
		end
		it "calculates right paths for c8" do
			expect(subject.c8.bishop_paths).to include([subject.b7, subject.a6])
			expect(subject.c8.bishop_paths).to include([subject.d7, subject.e6, subject.f5, subject.g4, subject.h3])
		end
		it "calculates right paths for f4" do
			expect(subject.f4.bishop_paths).to include([subject.g5, subject.h6])
			expect(subject.f4.bishop_paths).to include([subject.e5, subject.d6, subject.c7, subject.b8])
			expect(subject.f4.bishop_paths).to include([subject.e3, subject.d2, subject.c1])
			expect(subject.f4.bishop_paths).to include([subject.g3, subject.h2])
		end
	end

	describe "#calculate_knight_squares" do
		it "calculates right paths for a1" do
			expect(subject.a1.knight_squares).to include(subject.b3, subject.c2)
		end
		it "calculates right paths for c8" do
			expect(subject.c8.knight_squares).to include(subject.a7, subject.b6, subject.d6, subject.e7)
		end
		it "calculates right paths for f4" do
			expect(subject.f4.knight_squares).to include(subject.d3, subject.e2, subject.g2, subject.h3, subject.h5, subject.g6, subject.e6, subject.d5)
		end
	end

	describe "#calculate_rook_paths" do
		it "calculates right paths for a1" do
			expect(subject.a1.rook_paths).to include([subject.a2, subject.a3, subject.a4, subject.a5, subject.a6, subject.a7, subject.a8])
			expect(subject.a1.rook_paths).to include([subject.b1, subject.c1, subject.d1, subject.e1, subject.f1, subject.g1, subject.h1])
		end
		it "calculates right paths for c8" do
			expect(subject.c8.rook_paths).to include([subject.b8, subject.a8])
			expect(subject.c8.rook_paths).to include([subject.d8, subject.e8, subject.f8, subject.g8, subject.h8])
			expect(subject.c8.rook_paths).to include([subject.c7, subject.c6, subject.c5, subject.c4, subject.c3, subject.c2, subject.c1])
		end
		it "calculates right paths for f4" do
			expect(subject.f4.rook_paths).to include([subject.g4, subject.h4])
			expect(subject.f4.rook_paths).to include([subject.f5, subject.f6, subject.f7, subject.f8])
			expect(subject.f4.rook_paths).to include([subject.e4, subject.d4, subject.c4, subject.b4, subject.a4])
			expect(subject.f4.rook_paths).to include([subject.f3, subject.f2, subject.f1])
		end
	end

	describe "#calculate_queen_paths" do
		it "calculates right paths for a1" do
			expect(subject.a1.queen_paths).to include([subject.a2, subject.a3, subject.a4, subject.a5, subject.a6, subject.a7, subject.a8])
			expect(subject.a1.queen_paths).to include([subject.b1, subject.c1, subject.d1, subject.e1, subject.f1, subject.g1, subject.h1])
			expect(subject.a1.queen_paths).to include([subject.b2, subject.c3, subject.d4, subject.e5, subject.f6, subject.g7, subject.h8])
		end
		it "calculates right paths for c8" do
			expect(subject.c8.queen_paths).to include([subject.b8, subject.a8])
			expect(subject.c8.queen_paths).to include([subject.d8, subject.e8, subject.f8, subject.g8, subject.h8])
			expect(subject.c8.queen_paths).to include([subject.c7, subject.c6, subject.c5, subject.c4, subject.c3, subject.c2, subject.c1])
			expect(subject.c8.queen_paths).to include([subject.b7, subject.a6])
			expect(subject.c8.queen_paths).to include([subject.d7, subject.e6, subject.f5, subject.g4, subject.h3])
		end
		it "calculates right paths for f4" do
			expect(subject.f4.queen_paths).to include([subject.g4, subject.h4])
			expect(subject.f4.queen_paths).to include([subject.f5, subject.f6, subject.f7, subject.f8])
			expect(subject.f4.queen_paths).to include([subject.e4, subject.d4, subject.c4, subject.b4, subject.a4])
			expect(subject.f4.queen_paths).to include([subject.f3, subject.f2, subject.f1])
			expect(subject.f4.queen_paths).to include([subject.g5, subject.h6])
			expect(subject.f4.queen_paths).to include([subject.e5, subject.d6, subject.c7, subject.b8])
			expect(subject.f4.queen_paths).to include([subject.e3, subject.d2, subject.c1])
			expect(subject.f4.queen_paths).to include([subject.g3, subject.h2])		
		end
	end

	describe "#calculate_king_squares" do
		it "calculates right paths for a1" do
			expect(subject.a1.king_squares).to include(subject.a2, subject.b2, subject.b1)
		end
		it "calculates right paths for c8" do
			expect(subject.c8.king_squares).to include(subject.b8, subject.b7, subject.c7, subject.d7, subject.d8)
		end
		it "calculates right paths for f4" do
			expect(subject.f4.king_squares).to include(subject.g4, subject.g5, subject.f5, subject.e5, subject.e4, subject.e3, subject.f3, subject.g3)
		end
	end

	describe "#calculate_white_pawn_advances" do
		it "calculates right paths for a2" do
			expect(subject.a2.white_pawn_advances).to include([subject.a3, subject.a4])
		end
		it "leaves c1 empty" do
			expect(subject.c1.white_pawn_advances).to eql([])
		end
		it "leaves e8 empty" do
			expect(subject.e8.white_pawn_advances).to eql([])
		end
		it "calculates right paths for g6" do
			expect(subject.g6.white_pawn_advances).to eql([subject.g7])
		end		
	end

	describe "#calculate_black_pawn_advances" do
		it "calculates right paths for a7" do
			expect(subject.a7.black_pawn_advances).to include([subject.a6, subject.a5])
		end
		it "leaves c1 empty" do
			expect(subject.c1.black_pawn_advances).to eql([])
		end
		it "leaves e8 empty" do
			expect(subject.e8.black_pawn_advances).to eql([])
		end
		it "calculates right paths for g6" do
			expect(subject.g6.black_pawn_advances).to eql([subject.g5])
		end		
	end

	describe "#calculate_white_pawn_captures" do
		it "calculates right paths for a2" do
			expect(subject.a2.white_pawn_captures).to eql([subject.b3])
		end
		it "leaves c1 empty" do
			expect(subject.c1.white_pawn_captures).to eql([])
		end
		it "leaves e8 empty" do
			expect(subject.e8.white_pawn_captures).to eql([])
		end
		it "calculates right paths for g6" do
			expect(subject.g6.white_pawn_captures).to include(subject.f7, subject.h7)
		end		
	end

	describe "#calculate_black_pawn_captures" do
		it "calculates right paths for a7" do
			expect(subject.a7.black_pawn_captures).to eql([subject.b6])
		end
		it "leaves c1 empty" do
			expect(subject.c1.black_pawn_captures).to eql([])
		end
		it "leaves e8 empty" do
			expect(subject.e8.black_pawn_captures).to eql([])
		end
		it "calculates right paths for g6" do
			expect(subject.g6.black_pawn_captures).to include(subject.f5, subject.h5)
		end		
	end
end


