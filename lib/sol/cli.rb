require "readline"
require_relative "interpreter"
require_relative "version"

module Sol

	class CLI

		def initialize

			@interpreter = Interpreter.new

			if file = ARGV.first

				@interpreter.eval File.read(file)

			else

				repl()

			end

		end

		def repl

			Readline.completion_proc = proc {} # Disable tab

			puts "Sol #{VERSION} running on ruby #{RUBY_VERSION}"

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

	end

end
