require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'jeweler'

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

Jeweler::Tasks.new do |gemspec|
  gemspec.name = "activemerchant_patch_for_china"
  gemspec.summary = "A rails plugin to add an active_merchant patch for china online payment platform"
  gemspec.description = "A rails plugin to add an active_merchant patch for china online payment platform"
  gemspec.email = "flyerhzm@gmail.com"
  gemspec.homepage = "http://github.com/flyerhzm/activemerchant_patch_for_china"
  gemspec.authors = ["Richard Huang"]
  gemspec.add_dependency 'activemerchant', '>= 1.4.2'
end
Jeweler::GemcutterTasks.new
