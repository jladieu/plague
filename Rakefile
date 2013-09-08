require 'rubygems'
require 'bundler'
require 'rake'
require 'rspec/core/rake_task'
require 'plague/version'

desc 'Default: run the specs'
task :default => 'spec'

desc "Run unit specs"
RSpec::Core::RakeTask.new('spec') do |t|
   t.pattern = 'spec/**/[^_]*_spec.rb'
end

desc "Starts an irb console with the development plague gem loaded"
task :console do
  system "irb -I./lib -rplague"
end

task :compare_files, :original, :candidate, :num_words do |task, options|
  require 'plague'
  original_filename = options[:original]
  candidate_filename = options[:candidate]
  num_words = options[:num_words] ? options[:num_words].to_i : 4

  puts "Looking for plagiarism in #{original_filename} and #{candidate_filename}; seeking phrases of #{num_words}-word overlap."

  matcher = Plague::ExactWordMatcher.new(:num_words => num_words)
  result = matcher.match_files?(options[:original], options[:candidate])
  result.each do |phrase|
    puts phrase
  end
end