require "bundler/gem_tasks"
require "rake/testtask"

require "./lib/sol/lexer"

task :default => ["build:file"]

namespace :build do

	task :file => [:parser] do 

		sh "./lib/sol/sol ./lib/sol/example.sol"

	end

	task :repl => [:parser] do 

		sh "./lib/sol/sol"

	end

	task :parser do

		sh "racc -o ./lib/sol/parser.y ./lib/sol/grammar.y"

	end

end

Rake::TestTask.new do |t|

	t.libs.push "lib"

	t.test_files = FileList["lib/sol/spec/*.rb"]

	t.verbose = true;

	#test.pattern = "./lib/sol/tests/*.rb"

end
