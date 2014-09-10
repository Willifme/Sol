require "readline"
require_relative "interpreter"
require_relative "version"

module Sol

	class CLI

		def initialize(cmd)

			@interpreter = Interpreter.new

			if cmd

				if file = ARGV.first

					load(file)

				else

					repl()

				end

			end

		end

		def repl

			puts "Sol #{VERSION} running on Ruby #{RUBY_VERSION}"

			loop do

				begin

					line = Readline::readline('> ')

					Readline::HISTORY.push(line)

					value = @interpreter.eval(line)

					puts "#{value.ruby_value.inspect}"

				rescue Interrupt

					puts "" # To fix the prompt not being printed on a newline

					puts "Use quit(), exit() or Ctrl-D to exit the repl"

				end

			end

		end

		def load(file)

			@interpreter.eval(File.read(file))

		end

	end

end
