require "minitest/spec"
require "minitest/autorun"

require_relative "../lexer" # Reqiure lexer in above folder

describe "lexer" do
	
	before do

		@lexer = Sol::Lexer.new

		@literals = ["(", ")", ".", "!", "+", "-", "*", "/"]

		@operators = ["+", "-", "*", "/", "&&", "==", "!=", "<=", ">="]

	end

	it "can accept all keywords" do

		@lexer.KEYWORDS.each do |keyword|

			assert_equal [[keyword.upcase.to_sym, keyword]], @lexer.tokenise(keyword)

		end

	end

	it "can accept numbers" do

		assert_equal [[:NUMBER, 123]], @lexer.tokenise("123")

	end

	it "can accept double qouted strings" do

		# Escaped strings are the best

		assert_equal [[:STRING, "hello"]], @lexer.tokenise("\"hello\"")

	end

	it "can accept single qouted strings" do

		assert_equal [[:STRING, 'hello']], @lexer.tokenise("'hello'")

	end

	it "can accept operators" do 

		@operators.each do |operator| 

			assert_equal [[operator, operator]], @lexer.tokenise(operator)

		end

	end

	it "can accept singleline comments" do

		assert_equal [], @lexer.tokenise("//testing!")

	end

	it "can accept literals" do 

		@literals.each do |literal|

			assert_equal [[literal, literal]], @lexer.tokenise(literal)

		end

	end

end