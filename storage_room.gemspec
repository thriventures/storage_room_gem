# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "storage_room"
  s.version = "0.3.20"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sascha Konietzke"]
  s.date = "2012-03-01"
  s.description = "StorageRoom is a CMS system for Mobile Applications (iPhone, Android, BlackBerry, ...). This library gives you an ActiveModel-like interface to your data."
  s.email = "sascha@thriventures.com"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc",
    "TODO"
  ]
  s.files = [
    "Gemfile",
    "History.txt",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "TODO",
    "VERSION",
    "examples/associations.rb",
    "examples/authentication.rb",
    "examples/backup_uploads_from_export.rb",
    "examples/callbacks.rb",
    "examples/create_entry.rb",
    "examples/destroy_entry.rb",
    "examples/get_collections.rb",
    "examples/guidebooks.csv",
    "examples/import_csv.rb",
    "examples/manual_entry_definition.rb",
    "examples/pagination.rb",
    "examples/search_entries.rb",
    "examples/update_entry.rb",
    "examples/upload_remove_image.rb",
    "lib/console.rb",
    "lib/storage_room.rb",
    "lib/storage_room/accessors.rb",
    "lib/storage_room/array.rb",
    "lib/storage_room/embedded.rb",
    "lib/storage_room/embeddeds/field.rb",
    "lib/storage_room/embeddeds/fields/association_field.rb",
    "lib/storage_room/embeddeds/fields/associations/many_association_field.rb",
    "lib/storage_room/embeddeds/fields/associations/one_association_field.rb",
    "lib/storage_room/embeddeds/fields/atomic/array_field.rb",
    "lib/storage_room/embeddeds/fields/atomic/boolean_field.rb",
    "lib/storage_room/embeddeds/fields/atomic/date_field.rb",
    "lib/storage_room/embeddeds/fields/atomic/float_field.rb",
    "lib/storage_room/embeddeds/fields/atomic/integer_field.rb",
    "lib/storage_room/embeddeds/fields/atomic/json_field.rb",
    "lib/storage_room/embeddeds/fields/atomic/string_field.rb",
    "lib/storage_room/embeddeds/fields/atomic/time_field.rb",
    "lib/storage_room/embeddeds/fields/atomic_field.rb",
    "lib/storage_room/embeddeds/fields/compound/attachment_field.rb",
    "lib/storage_room/embeddeds/fields/compound/file_field.rb",
    "lib/storage_room/embeddeds/fields/compound/image_field.rb",
    "lib/storage_room/embeddeds/fields/compound/location_field.rb",
    "lib/storage_room/embeddeds/fields/compound_field.rb",
    "lib/storage_room/embeddeds/file.rb",
    "lib/storage_room/embeddeds/image.rb",
    "lib/storage_room/embeddeds/image_version.rb",
    "lib/storage_room/embeddeds/location.rb",
    "lib/storage_room/embeddeds/webhook_definition.rb",
    "lib/storage_room/extensions/const_defined.rb",
    "lib/storage_room/extensions/symbol.rb",
    "lib/storage_room/identity_map.rb",
    "lib/storage_room/model.rb",
    "lib/storage_room/models/collection.rb",
    "lib/storage_room/models/deleted_entry.rb",
    "lib/storage_room/models/entry.rb",
    "lib/storage_room/plugins.rb",
    "lib/storage_room/proxy.rb",
    "lib/storage_room/resource.rb",
    "lib/storage_room/webhook_call.rb",
    "spec/fixtures/collection.json",
    "spec/fixtures/collections.json",
    "spec/fixtures/export_collection.json",
    "spec/fixtures/export_entries.json",
    "spec/fixtures/image.png",
    "spec/fixtures/validation_error.json",
    "spec/fixtures/webhook_call.json",
    "spec/fixtures/webhook_call_association.json",
    "spec/spec_helper.rb",
    "spec/storage_room/accessors_spec.rb",
    "spec/storage_room/array_spec.rb",
    "spec/storage_room/embedded_spec.rb",
    "spec/storage_room/embeddeds/field_spec.rb",
    "spec/storage_room/embeddeds/fields/association_field_spec.rb",
    "spec/storage_room/embeddeds/fields/associations/many_association_field_spec.rb",
    "spec/storage_room/embeddeds/fields/associations/one_association_field_spec.rb",
    "spec/storage_room/embeddeds/fields/atomic/array_field_spec.rb",
    "spec/storage_room/embeddeds/fields/atomic/boolean_field_spec.rb",
    "spec/storage_room/embeddeds/fields/atomic/date_field_spec.rb",
    "spec/storage_room/embeddeds/fields/atomic/float_field_spec.rb",
    "spec/storage_room/embeddeds/fields/atomic/integer_field_spec.rb",
    "spec/storage_room/embeddeds/fields/atomic/json_field_spec.rb",
    "spec/storage_room/embeddeds/fields/atomic/string_field_spec.rb",
    "spec/storage_room/embeddeds/fields/atomic/time_field_spec.rb",
    "spec/storage_room/embeddeds/fields/atomic_field_spec.rb",
    "spec/storage_room/embeddeds/fields/compound/attachment_field_spec.rb",
    "spec/storage_room/embeddeds/fields/compound/file_field_spec.rb",
    "spec/storage_room/embeddeds/fields/compound/image_field_spec.rb",
    "spec/storage_room/embeddeds/fields/compound/location_field_spec.rb",
    "spec/storage_room/embeddeds/fields/compound_field_spec.rb",
    "spec/storage_room/embeddeds/file_spec.rb",
    "spec/storage_room/embeddeds/image_spec.rb",
    "spec/storage_room/embeddeds/image_version_spec.rb",
    "spec/storage_room/embeddeds/location_spec.rb",
    "spec/storage_room/embeddeds/webhook_definition_spec.rb",
    "spec/storage_room/extensions/symbol_spec.rb",
    "spec/storage_room/identity_map_spec.rb",
    "spec/storage_room/model_spec.rb",
    "spec/storage_room/models/collection_spec.rb",
    "spec/storage_room/models/deleted_entry_spec.rb",
    "spec/storage_room/models/entry_spec.rb",
    "spec/storage_room/proxy_spec.rb",
    "spec/storage_room/resource_spec.rb",
    "spec/storage_room/webhook_call_spec.rb",
    "spec/storage_room_spec.rb",
    "storage_room.gemspec",
    "tasks/storage_room.rake"
  ]
  s.homepage = "http://github.com/thriventures/storage_room_gem"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "StorageRoom API Wrapper (ActiveModel style)"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<storage_room>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_development_dependency(%q<webmock>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_development_dependency(%q<webmock>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_development_dependency(%q<webmock>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_development_dependency(%q<webmock>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_development_dependency(%q<webmock>, [">= 0"])
      s.add_runtime_dependency(%q<json>, [">= 0"])
      s.add_runtime_dependency(%q<httparty>, [">= 0.6.1"])
      s.add_runtime_dependency(%q<activesupport>, [">= 3.1.0"])
      s.add_runtime_dependency(%q<activemodel>, [">= 3.1.0"])
      s.add_runtime_dependency(%q<mime-types>, [">= 0"])
    else
      s.add_dependency(%q<storage_room>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<webmock>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<webmock>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<webmock>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<webmock>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<webmock>, [">= 0"])
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<httparty>, [">= 0.6.1"])
      s.add_dependency(%q<activesupport>, [">= 3.1.0"])
      s.add_dependency(%q<activemodel>, [">= 3.1.0"])
      s.add_dependency(%q<mime-types>, [">= 0"])
    end
  else
    s.add_dependency(%q<storage_room>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<webmock>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<webmock>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<webmock>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<webmock>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<webmock>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<httparty>, [">= 0.6.1"])
    s.add_dependency(%q<activesupport>, [">= 3.1.0"])
    s.add_dependency(%q<activemodel>, [">= 3.1.0"])
    s.add_dependency(%q<mime-types>, [">= 0"])
  end
end

