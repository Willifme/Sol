require "bundler/gem_tasks"
require "rake/testtask"

require "./lib/sol/lexer"

task :default => ["build:file"]

namespace :build do

	task :file => [:parser] do

		# Have to escape strings otherwise everything goes wrong

		sh "ruby -r './lib/sol' -e \"Sol::CLI.new(false).load('./lib/sol/example.sol')\"" 

	end

	task :repl => [:parser] do

		sh "ruby -r './lib/sol' -e 'Sol::CLI.new(false).repl'"

	#	sh "bin/sol"

	end

	task :lexerepl do

		sh "ruby -r './lib/sol/lexer' -e 'Sol::Lexer.new.repl'"

	end

	task :parser do

		sh "racc ./lib/sol/grammar.y -o ./lib/sol/parser.rb"

	end

end

Rake::TestTask.new do |t|

	t.libs.push "lib"

	t.test_files = FileList["lib/sol/spec/*.rb"]

	t.verbose = true;

	#test.pattern = "./lib/sol/tests/*.rb"

end
