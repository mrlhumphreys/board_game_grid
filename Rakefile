require 'rake/testtask'
require "bundler/gem_tasks"
task :default => :spec

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/board_game_grid/*_test.rb']
end

desc 'run tests'
task :default => :test
