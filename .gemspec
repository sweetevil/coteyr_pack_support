# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'bundler/version'

Gem::Specification.new do |s|
  s.name        = "coteyr_pack"
  s.version     = "3.2.6"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Robert Cotey"]
  s.email       = ["coteyr@coteyr.net"]
  s.homepage    = "http://www.coteyr.net"
  s.summary     = "Internal tools and modifications to old plugins/gems"
  s.description = "Internal tools and modificatoins to old plugins and gems to keep ruby development fast and cheap for my clients."
  s.required_rubygems_version = ">= 1.3.6"
  s.files        = Dir.glob("{bin,lib}/**/*") + %w()
  s.require_path = 'lib'
end
