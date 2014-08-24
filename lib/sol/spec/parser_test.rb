require "minitest/autorun"
require "minitest/spec"

require_relative "../parser.rb" # Reqiure parser in above folder

describe "parser" do 

	before do 

		@parser = Sol::Parser.new

		@operators = ["||", "&&", "==", "!=", ">", ">=", "<", "<=", "+", "-", "*", "/"]

	end

	it "can do operations" do

		@operators.each do |operator|

			@parser.parse "1#{operator}1", show_tokens = false

		end

	end

	it "can do functions" do 

		@parser.parse "func hello() {1 + 1}", show_tokens =  false

	end

	it "can do if statements" do

		@parser.parse "if 1 == 1 { 1 + 1 }", show_tokens =  false

	end

end