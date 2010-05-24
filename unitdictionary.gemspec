# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)

Gem::Specification.new do |s|
  s.name      = "unit_dictionary"
  s.version   =  '0.1'
  s.summary   = 'An object to make interfacing with UCSDs unit dictionary easier'
  
  s.required_rubygems_version = '>=1.3.7'
  s.files        = Dir.glob("{bin,lib}/**/*")
  s.require_path = 'lib'
  
  s.author    = 'sven bohm'
end