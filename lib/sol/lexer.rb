# encoding=utf-8

require "readline"

module Sol

    class Lexer

        attr_reader :KEYWORDS

        IDENTIFIER = /\A([a-zA-Z]\p{WORD}+\w*)/

        NUMBER = /\A([0-9]+)/

        STRING = /\A["'](.*?)["']/

        OPERATOR = /\A(\|\||&&|==|!=|<=|>=)/

        WHITESPACE = /\A([ \t\r\n]+)/

        NEWLINE = /\A([\r\n])+/

        COMMENT = /\A(\/[\/]+[^\r\n]*)/

        def initialize

            @KEYWORDS = ["func", "if", "true", "false", "null"]

        end

        # This is how to implement a very simple scanner.
        # Scan one caracter at the time until you find something to parse.

        def tokenise(input)

            @input = input.chomp # Cleanup code by remove extra line breaks

            @i = 0 # Current character position we're parsing

            @tokens = [] # Collection of all parsed tokens in the form [:TOKEN_TYPE, value]

            while @i < @input.length

              @chunk = @input[@i..-1]

              extract_next_token

            end

            return @tokens

        end

        def repl

            loop do

              line = Readline::readline('> ')

              exit(0) if line.nil? || line == 'quit'

              Readline::HISTORY.push(line)

              puts "#{tokenise(line)}" # Brackets are for clarity purposes

            end

        end

        private

        def extract_next_token

            return if identifier_token

            return if number_token

            return if string_token

            return if remove_comment_token

            return if whitespace_token

            return literal_token


        end

        # Matching if, print, method names, etc.

        def identifier_token

            return false unless identifier = @chunk[IDENTIFIER, 1]

            # Keywords are special identifiers tagged with their own name, 'if' will result
            # in an [:IF, "if"] token

            if @KEYWORDS.include?(identifier)

              @tokens << [identifier.upcase.to_sym, identifier]

            else

              @tokens << [:IDENTIFIER, identifier]

            end

            @i += identifier.length

        end

        def number_token

            return false unless number = @chunk[NUMBER, 1]

            @tokens << [:NUMBER, number.to_i]

            @i += number.length

        end

        def string_token

            return false unless string = @chunk[STRING, 1]

            @tokens << [:STRING, string]

            @i += string.length + 2

        end

        def remove_comment_token

            return false unless comment = @chunk[COMMENT, 1]

            @i += comment.length

        end

        # Ignore whitespace

        def whitespace_token

            return false unless whitespace = @chunk[WHITESPACE, 1]

            @i += whitespace.length

        end

        # We treat all other single characters as a token. Eg.: ( ) , . !

        def literal_token

            value = @chunk[NEWLINE, 1]

            if value

                puts "Tokens last: #{@tokens.last}, #{@tokens.last[0]}"

                @tokens << ["\n", "\n"]  unless @tokens.last && @tokens.last[0] == "\n"

                return @i + value.length

            end

            value = @chunk[OPERATOR, 1]

            value ||= @chunk[0, 1]

            @tokens << [value, value]

            @i += value.length

        end

    end

end
