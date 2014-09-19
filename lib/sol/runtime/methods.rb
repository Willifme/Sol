module Sol

    module RuntimeModel
        
        class Methods

            def initialize(class_type)

                @class_type = class_type

                # Add a few core methods to the runtime

                # Or (||)
                Runtime[@class_type].runtime_methods["||"] = proc do |receiver, arguments|

                    Runtime[@class_type].new_with_value(receiver.ruby_value || arguments.first.ruby_value)

                end

                # And (&&)
                Runtime[@class_type].runtime_methods["&&"] = proc do |receiver, arguments|

                    Runtime[@class_type].new_with_value(receiver.ruby_value && arguments.first.ruby_value)

                end

                # Equal to (==)
                Runtime[@class_type].runtime_methods["=="] = proc do |receiver, arguments|

                    Runtime[@class_type].new_with_value(receiver.ruby_value == arguments.first.ruby_value)

                end

                # Does not equal to (!=)
                Runtime[@class_type].runtime_methods["!="] = proc do |receiver, arguments|

                    Runtime[@class_type].new_with_value(receiver.ruby_value != arguments.first.ruby_value)

                end

                # Greater than (>)
                Runtime[@class_type].runtime_methods[">"] = proc do |receiver, arguments|

                    Runtime[@class_type].new_with_value(receiver.ruby_value > arguments.first.ruby_value)

                end

                # Greater than or equal to (>=)
                Runtime[@class_type].runtime_methods[">="] = proc do |receiver, arguments|

                    Runtime[@class_type].new_with_value(receiver.ruby_value >= arguments.first.ruby_value)

                end

                # Less than (<)
                Runtime[@class_type].runtime_methods["<"] = proc do |receiver, arguments|

                    Runtime[@class_type].new_with_value(receiver.ruby_value < arguments.first.ruby_value)

                end

                # Less than or equal to (>=)
                Runtime[@class_type].runtime_methods["<="] = proc do |receiver, arguments|

                    Runtime[@class_type].new_with_value(receiver.ruby_value <= arguments.first.ruby_value)

                end

                # Add
                Runtime[@class_type].runtime_methods["+"] = proc do |receiver, arguments|

                    Runtime[@class_type].new_with_value(receiver.ruby_value + arguments.first.ruby_value)

                end

                # Minus
                Runtime[@class_type].runtime_methods["-"] = proc do |receiver, arguments|

                    Runtime[@class_type].new_with_value(receiver.ruby_value - arguments.first.ruby_value)

                end

                # Times 
                Runtime[@class_type].runtime_methods["*"] = proc do |receiver, arguments|

                    Runtime[@class_type].new_with_value(receiver.ruby_value * arguments.first.ruby_value)

                end

                # Divide
                Runtime[@class_type].runtime_methods["/"] = proc do |receiver, arguments|

                    Runtime[@class_type].new_with_value(receiver.ruby_value / arguments.first.ruby_value)

                end

            end

        end

    end

end