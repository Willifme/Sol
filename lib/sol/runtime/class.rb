require_relative "object"

module Sol

	module RuntimeModel

		# Represents a Sol class in the Ruby world. Classes are objects in Sol so they inherit from SolObject
		class SolClass < SolObject

			attr_reader :runtime_methods

			# Create a new class. Number is an instance of Class for example
			def initialize

				@runtime_methods = {}

				# Check if we're bootstrapping (launching the runtime). During this process the
				# runtime is not fully initialised and core classes do not yet exists, so we defer
				# using those once the language is bootstrapped.
				# This solves the chicken-or-the-egg problem with the Class class. We can
				# initialise Class then set Class.class = Class.
				if defined?(Runtime) # RuntimeModel is a temporary name

					runtime_class = Runtime["Class"]

				else

					runtime_class = nil

				end

				super(runtime_class)

			end

			# Lookup a method
			def lookup(method_name)

				method = @runtime_methods[method_name]

				unless method

					raise "Method not found: #{method_name}"

				end

				return method

			end

			# Create a new instance of the class
			def new

				SolObject.new(self)

			end

			# Create an instance of this Sol class that holds a Ruby value
			def new_with_value(value)

				SolObject.new(self, value)

			end

		end

	end

end
