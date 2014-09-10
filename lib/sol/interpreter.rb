require_relative "parser"
require_relative "runtime"

module Sol

	class Interpreter

		def initialize

			@parser = Sol::Parser.new

		end

		def eval(input)

			@parser.parse(input).eval(RuntimeModel::Runtime)

		end

	end

	class Nodes

		# This method is the "interpreter" part of our language. All nodes know how to eval
		# itself and returns the result of its evaluation by implementing the "eval" method.
		# The "context" variable is the environment in which the node is evaluated (local variables, current class, etc.).
		def eval(context)

			return_value = nil

			nodes.each do |node|

				return_value = node.eval(context)

			end


			# The last value evaluated in a method is the return value. Or null if node
			return_value || RuntimeModel::Runtime["null"]

		end

	end

	class NumberNode

		def eval(context)

			# Here we access the Runtime, which we'll see in the next section, to create a new instance of the Number class
			RuntimeModel::Runtime["Number"].new_with_value(value)

		end

	end

	class StringNode

		def eval(context)

			RuntimeModel::Runtime["String"].new_with_value(value)

		end

	end

	class TrueNode

		def eval(context)

			RuntimeModel::Runtime["true"]

		end

	end

	class FalseNode

		def eval(context)

			RuntimeModel::Runtime["false"]

		end

	end

	class NullNode

		def eval(context)

			RuntimeModel::Runtime["null"]

		end

	end

	class CallNode

		def eval(context)

			if receiver.nil? && arguments.empty? && RuntimeModel::Runtime.locals[method]

				return context::Runtime.locals[method]

			else

				if receiver

					value = receiver.eval(context)

				else

					value = RuntimeModel::Runtime.current_self # I think this works

				end

				eval_arguments = arguments.map do |arg|

					arg.eval(context)

				end

				value.call(method, eval_arguments)

			end

		end

	end

	class GetConstantNode

		def eval(context)

			context[name]

		end

	end

	class SetConstantNode

		def eval(context)

			context[name] = value.eval(context)

		end

	end

	class SetLocalNode

		def eval(context)

			context.locals[name] = value.eval(context)

		end

	end

	class FuncNode

		def eval(context)

			# Defining a method is adding a method to the current class
			method = RuntimeModel::SolFunction.new(params, body)

			RuntimeModel::Runtime.current_class.runtime_methods[name] = method # I think this works

		end

	end

	class IfNode

		def eval(context)

			# We turn the condition node innto a Ruby value to use Ruby's "if" control structure
			if condition.eval(context).ruby_value

				body.eval(context)

			end

		end

	end

end
