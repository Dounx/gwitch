# frozen_string_literal: true

require "rake/testtask"

task default: :test

task :console do
  exec "irb -r gwitch -I ./lib"
end

Rake::TestTask.new do |t|
  t.libs = %w[lib test]
  t.test_files = FileList["test/**/*_test.rb"]
  t.warning = true
  t.verbose = true
end