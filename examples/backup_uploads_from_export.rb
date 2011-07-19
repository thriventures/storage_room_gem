#!/usr/bin/env ruby -rubygems

require File.join(File.dirname(__FILE__), '..', 'lib', 'storage_room')

collection_path = ::File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec', 'fixtures', 'export_collection.json'))
entry_path      = ::File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec', 'fixtures', 'export_entries.json'))
download_path   = ::File.expand_path(File.join(File.dirname(__FILE__), 'downloads'))

collection = StorageRoom::Resource.new_from_json_file(collection_path)
entry_class = collection.entry_class

attachment_fields = collection.fields.select{|f| f.is_a?(StorageRoom::AttachmentField)}

puts "Loaded Collection '#{collection.name}' with attachment fields: #{attachment_fields.map(&:name).join(', ')}"
puts "Downloading into '#{download_path}'"

StorageRoom::Array.new_from_json_file(entry_path).resources.each do |entry|
  attachment_fields.each do |field|
    if file = entry.send(field.identifier)  
      puts "Downloading #{file[:@url]} including all versions"
      file.download_to_directory(download_path)
    end
  end
end
