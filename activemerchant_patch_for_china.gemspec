lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require "activemerchant_patch_for_china/version"

Gem::Specification.new do |s|
  s.name        = "activemerchant_patch_for_china"
  s.version     = ActivemerchantPatchForChina::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Richard Huang"]
  s.email       = ["flyerhzm@gmail.com"]
  s.homepage    = "http://github.com/flyerhzm/activemerchant_patch_for_china"
  s.summary     = "A rails plugin to add an active_merchant patch for china online payment platform"
  s.description = "A rails plugin to add an active_merchant patch for china online payment platform"
  s.required_rubygems_version = ">= 1.3.6"
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_development_dependency "activesupport"
end
