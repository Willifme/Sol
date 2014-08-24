module Sol

	module RuntimeModel

		require_relative "object"

		# Represents a method defined in the runtime
		class SolFunction < SolObject

			def initialize(params, body)

				@params = params

				@body = body

			end

			def call(reciever, arguments)

				# Create a context of evaluation in which the method will execute
				context = Context.new(reciever)

				if @params.class == "NullClass"

					# Assign arguments to local variables
					@params.to_enum.each_with_index do |param, index|

						context.locals[param] = arguments[index]

					end

				end

				return @body.eval(context)

			end

		end

	end

end
