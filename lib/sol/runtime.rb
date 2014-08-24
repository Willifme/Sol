=begin
require_relative "runtime/object"
require_relative "runtime/class"
require_relative "runtime/method"
require_relative "runtime/context"
require_relative "runtime/bootstrap"
=end

Dir[File.dirname(__FILE__) + "/runtime/*.rb"].each { |file| require file }

module Sol

end