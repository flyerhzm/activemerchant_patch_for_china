$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "bundler"
Bundler.setup

require "rake"
require "rdoc/task"
require "rake/testtask"

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the activemerchant_patch_for_china plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the activemerchant_patch_for_china plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'ActivemerchantPatchForChina'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require "activemerchant_patch_for_china/version"

task :build do
  system "gem build activemerchant_patch_for_china.gemspec"
end

task :install => :build do
  system "sudo gem install activemerchant_patch_for_china-#{ActivemerchantPatchForChina::VERSION}.gem"
end

task :release => :build do
  puts "Tagging #{ActivemerchantPatchForChina::VERSION}..."
  system "git tag -a #{ActivemerchantPatchForChina::VERSION} -m 'Tagging #{ActivemerchantPatchForChina::VERSION}'"
  puts "Pushing to Github..."
  system "git push --tags"
  puts "Pushing to rubygems.org..."
  system "gem push activemerchant_patch_for_china-#{ActivemerchantPatchForChina::VERSION}.gem"
end
