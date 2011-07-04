require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "storage_room"
    gem.summary = %Q{StorageRoom API Wrapper (ActiveModel style)}
    gem.description = %Q{StorageRoom is a CMS system for Mobile Applications (iPhone, Android, BlackBerry, ...). This library gives you an ActiveModel-like interface to your data.}
    gem.email = "sascha@thriventures.com"
    gem.homepage = "http://github.com/thriventures/storage_room_gem"
    gem.authors = ["Sascha Konietzke"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_development_dependency "webmock"
      
    gem.add_dependency 'httparty', '>= 0.6.1'
    gem.add_dependency 'activesupport', '>= 3.0.0'
    gem.add_dependency 'mime-types'
    
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end


require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = ["-c", "-f progress", "-r ./spec/spec_helper.rb"]
  t.pattern = 'spec/**/*_spec.rb'
end


task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "storage_room #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Dir['tasks/**/*.rake'].each { |t| load t }