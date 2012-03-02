# -*- encoding: utf-8 -*-

$:.push File.expand_path("../lib", __FILE__)
require "storage_room/version"

Gem::Specification.new do |s|
  s.name = "storage_room"
  s.version = StorageRoom::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Sascha Konietzke"]
  s.email = "sascha@thriventures.com"
  s.homepage = "http://github.com/thriventures/storage_room_gem"  
  s.summary = "StorageRoom API Wrapper (ActiveModel style)"
  s.description = "StorageRoom is a CMS system for Mobile Applications (iPhone, Android, BlackBerry, ...). This library gives you an ActiveModel-like interface to your data."
  
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=

  s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
  s.add_development_dependency(%q<webmock>, [">= 0"])
  s.add_runtime_dependency(%q<json>, [">= 0"])
  s.add_runtime_dependency(%q<httparty>, [">= 0.6.1"])
  s.add_runtime_dependency(%q<activesupport>, [">= 3.1.0"])
  s.add_runtime_dependency(%q<activemodel>, [">= 3.1.0"])
  s.add_runtime_dependency(%q<mime-types>, [">= 0"])

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

