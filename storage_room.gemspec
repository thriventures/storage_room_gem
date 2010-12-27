# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{storage_room}
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sascha Konietzke"]
  s.date = %q{2010-12-27}
  s.description = %q{StorageRoom is a CMS system for Mobile Applications (iPhone, Android, BlackBerry, ...). This library gives you an ActiveModel-like interface to your data.}
  s.email = %q{sascha@thriventures.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc",
    "TODO"
  ]
  s.files = [
    "History.txt",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "TODO",
    "VERSION",
    "examples/authentication.rb",
    "examples/create_entry.rb",
    "examples/destroy_entry.rb",
    "examples/get_collections.rb",
    "examples/guidebooks.csv",
    "examples/import_csv.rb",
    "examples/search_entries.rb",
    "examples/update_entry.rb",
    "lib/storage_room.rb",
    "lib/storage_room/array.rb",
    "lib/storage_room/attributes.rb",
    "lib/storage_room/base.rb",
    "lib/storage_room/embedded.rb",
    "lib/storage_room/embeddeds/file.rb",
    "lib/storage_room/embeddeds/location.rb",
    "lib/storage_room/field.rb",
    "lib/storage_room/model.rb",
    "lib/storage_room/models/collection.rb",
    "lib/storage_room/models/entry.rb",
    "spec/fixtures/collection.json",
    "spec/fixtures/collections.json",
    "spec/fixtures/validation_error.json",
    "spec/spec_helper.rb",
    "spec/storage_room/array_spec.rb",
    "spec/storage_room/attributes_spec.rb",
    "spec/storage_room/base_spec.rb",
    "spec/storage_room/embedded_spec.rb",
    "spec/storage_room/embeddeds/file_spec.rb",
    "spec/storage_room/embeddeds/location_spec.rb",
    "spec/storage_room/field_spec.rb",
    "spec/storage_room/model_spec.rb",
    "spec/storage_room/models/collection_spec.rb",
    "spec/storage_room/models/entry_spec.rb",
    "spec/storage_room_spec.rb",
    "storage_room.gemspec"
  ]
  s.homepage = %q{http://github.com/thriventures/storage_room_gem}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{StorageRoom API Wrapper (ActiveModel style)}
  s.test_files = [
    "examples/authentication.rb",
    "examples/create_entry.rb",
    "examples/destroy_entry.rb",
    "examples/get_collections.rb",
    "examples/import_csv.rb",
    "examples/search_entries.rb",
    "examples/update_entry.rb",
    "spec/spec_helper.rb",
    "spec/storage_room/array_spec.rb",
    "spec/storage_room/attributes_spec.rb",
    "spec/storage_room/base_spec.rb",
    "spec/storage_room/embedded_spec.rb",
    "spec/storage_room/embeddeds/file_spec.rb",
    "spec/storage_room/embeddeds/location_spec.rb",
    "spec/storage_room/field_spec.rb",
    "spec/storage_room/model_spec.rb",
    "spec/storage_room/models/collection_spec.rb",
    "spec/storage_room/models/entry_spec.rb",
    "spec/storage_room_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_development_dependency(%q<webmock>, [">= 0"])
      s.add_runtime_dependency(%q<httparty>, [">= 0.6.1"])
      s.add_runtime_dependency(%q<activesupport>, [">= 3.0.0"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<webmock>, [">= 0"])
      s.add_dependency(%q<httparty>, [">= 0.6.1"])
      s.add_dependency(%q<activesupport>, [">= 3.0.0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<webmock>, [">= 0"])
    s.add_dependency(%q<httparty>, [">= 0.6.1"])
    s.add_dependency(%q<activesupport>, [">= 3.0.0"])
  end
end

