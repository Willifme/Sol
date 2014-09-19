
class Parser

	#Declare tokens by the lexer

	token IF
	token FUNC
	token INT STRING
	token NEWLINE
	token NUMBER
	token STRING
	token TRUE FALSE NULL
	token IDENTIFIER
	token CONSTANT
	token RETURN

	prechigh
		left "."
		left "!"
		left "*" "/"
		left "+" "-"
		left ">" ">=" "<" "<="
		left "==" "!="
		left "&&"
		left "||"
		left "="
		left ","
	preclow

	rule

	# All rules are declared in this format:
	#
	#   RuleName:
	#     OtherRule TOKEN AnotherRule    { code to run when this matches }
	#   | OtherRule                      { ... }
	#   ;
	#
	# In the code section (inside the {...} on the right):
	# - Assign to "result" the value returned by the rule.

	# All parsinng will end in this rule, being the trunk of the AST
	Root:
		/* nothing */							{ result = Nodes.new([]) }
		| Expressions                       	{ result = val[0] }
		;

	# Any list of expressions are seperated by line breaks
	Expressions:
		Expression 								{ result = Nodes.new(val) }
		| Expressions Expression  				{ result = val[0] << val[1] }
		# To ignore trailing line breaks
		| Expressions Terminator    			{ result = val[0] }
		| Terminator							{ result = Nodes.new([]) }
		;

	# All types of expressions in our language
	Expression:
		Literal
		| Call
		| Operator
		| Constant
		| Assign
		| Func
		| If
		| "(" Expression ")" 					{ result = val[1] }
		;

	# All tokens that can terminate and expression
	Terminator:
		NEWLINE
		| ";"
		;

	# All hardcoded values
	Literal:
		NUMBER									{ result = NumberNode.new(val[0]) }
		| STRING								{ result = StringNode.new(val[0]) }
		| TRUE 									{ result = TrueNode.new }
		| FALSE									{ result = FalseNode.new }
		| NULL									{ result = NullNode.new }
		;

	# A method call
	Call:
		# Method
	#	IDENTIFIER 				    			{ result = CallNode.new(nil, val[0], []) }
		# method arguments are optional
		 IDENTIFIER "(" ArgList ")"			{ result = CallNode.new(nil, val[0], val[2]) }
		# receiver.method
	#	| Expression "." IDENTIFIER				{ result = CallNode.new(val[0], val[2], []) }
		# receiver.method(arguments) arguments are optional
		| Expression "." IDENTIFIER "(" ArgList ")"	{ result = CallNode.new(val[0], val[2], val[4]) }
		;

	ArgList:
		/* Nothing */							{ result = [] }
		| Expression 							{ result = val }
		| ArgList "," Expression 				{ result = val[0] << val[2]}
		;

	Operator:
		# Binary operators
		Expression "||" Expression 				{ result = CallNode.new(val[0], val[1], [val[2]]) }
		| Expression '&&' Expression 			{ result = CallNode.new(val[0], val[1], [val[2]]) }
		| Expression '==' Expression 			{ result = CallNode.new(val[0], val[1], [val[2]]) }
		| Expression '!=' Expression 			{ result = CallNode.new(val[0], val[1], [val[2]]) }
		| Expression '>' Expression   		    { result = CallNode.new(val[0], val[1], [val[2]]) }
		| Expression '>=' Expression 			{ result = CallNode.new(val[0], val[1], [val[2]]) }
		| Expression '<' Expression  			{ result = CallNode.new(val[0], val[1], [val[2]]) }
		| Expression '<=' Expression 			{ result = CallNode.new(val[0], val[1], [val[2]]) }
		| Expression '+' Expression  			{ result = CallNode.new(val[0], val[1], [val[2]]) }
		| Expression '-' Expression  			{ result = CallNode.new(val[0], val[1], [val[2]]) }
		| Expression '*' Expression 			{ result = CallNode.new(val[0], val[1], [val[2]]) }
		| Expression '/' Expression  			{ result = CallNode.new(val[0], val[1], [val[2]]) }
		;

	Constant:
		CONSTANT 								{ result = GetConstantNode.new(val[0]) }
		;

	# Assignment to a variable or constant
	Assign:
		IDENTIFIER "=" Expression 				{ result = SetLocalNode.new(val[0], val[2]) }
		| CONSTANT "=" Expression 				{ result = SetLocalNode.new(val[0], val[2]) }
		;

	# Method definition
	Func:
		# ParamList is optional
		FUNC IDENTIFIER "(" ParamList ")" Block { result = FuncNode.new(val[1], val[3], val[5]) }
		# Shift by one to account for arrow and type
		| FUNC IDENTIFIER "(" ParamList ")" "->" Types Block { result = FuncNode.new(val[1], val[3], val[7]) } 
		;

	ParamList:
		/* Nothing */
		| IDENTIFIER 							{ result = [] }
		| ParamList "," IDENTIFIER 				{ result = val }
		;

	Types:
	    INT                                     { result = [] }
	    | STRING                                { result = [] }
	    ;

	# If block
	If:
		IF Expression Block 					{ result = IfNode.new(val[1], val[2]) }
		;

	# A block of code all the work was done by the lexer
	Block:
		"{" Expressions "}" 					{ result = val[1] }
		| "{" Expressions RETURN Expression "}" { result = ReturnNode.new(val[3])}
		| "{" RETURN Expression "}"             { result = ReturnNode.new(val[2]) }
		;

end

---- header

require_relative "lexer"

require_relative "nodes"

module Sol

---- inner

		# This code will be puts as-is in the Parser class
		def parse(input, show_tokens=true)

			@tokens = Sol::Lexer.new.tokenise(input) # Tokenise the code using our lexer

			puts @tokens.inspect if show_tokens

			do_parse # Kickoff the parsing process

		end

		def next_token

			@tokens.shift

		end

---- footer

end # End the module
