#!/usr/bin/env ruby -rubygems

require File.join(File.dirname(__FILE__), 'authentication')

path = ::File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec', 'fixtures', 'image.png'))

collection = StorageRoom::Collection.find('4f7c9fa6421aa9e48a000092')

# Upload Image or File
entry = collection.entry_class.new(:name => "StorageRoom Logo", :file => StorageRoom::Image.new_with_filename(path))

# optionally change the request timeout if you upload big files
StorageRoom.timeout = 100

if entry.save
  puts "Entry saved (#{entry[:@url]})"
  puts "URL of the uploaded image is #{entry.image.url}"
  puts "URL of the automatically generated thumbnail is #{entry.image.url(:thumbnail)}" # Multiple Image Versions can be specified in the interface
else
  puts "Entry could not be saved: #{entry.errors.join(', ')}"
end

# Remove Image or File

entry.image.remove = true

if entry.save
  puts "The Image of the Entry has been removed"
else
  puts "The Image of the Entry could not be removed: #{entry.errors.join(', ')}"
end