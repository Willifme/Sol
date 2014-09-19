require_relative "class"
require_relative "context"
require_relative "methods"

module Sol

	module RuntimeModel

		# Bootstrap the runtime. This is where we assemble all the classes and objects together to form the runtime
		# Whats happening in the runtime
		sol_class = SolClass.new

		sol_class.runtime_class = sol_class

		object_class = SolClass.new

		object_class.runtime_class = sol_class

		Runtime = Context.new(object_class.new)

		Runtime["Class"] = sol_class

		Runtime["Object"] = object_class

		Runtime["Number"] = object_class # I think this works

		Runtime["String"] = object_class # I think this works

		# Everything is an object in  our language, even true, false and null. So they need to have a class too.
		Runtime["TrueClass"] = SolClass.new

		Runtime["FalseClass"] = SolClass.new

		Runtime["NullClass"] = SolClass.new

		Runtime["true"] = Runtime["TrueClass"].new_with_value(true)

		Runtime["false"] = Runtime["FalseClass"].new_with_value(false)

		Runtime["null"] = Runtime["TrueClass"].new_with_value(nil)

		# Add a few core methods to the runtime

		# Print an object to the console, e.g print("hello, world")
		Runtime["Object"].runtime_methods["print"] = proc do |receiver, arguments|

			puts arguments.first.ruby_value

			Runtime["Null"]

		end

		# Exit 
		Runtime["Object"].runtime_methods["exit"] = proc do |receiver|

			Runtime["Null"]

			exit(0)

		end

		# Quit
		Runtime["Object"].runtime_methods["quit"] = proc do |receiver|

			Runtime["Null"]

			exit(0)

		end

		Methods.new("Object") # Will do for now

	end

end
