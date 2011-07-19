#!/usr/bin/env ruby -rubygems

require File.join(File.dirname(__FILE__), 'authentication')

collection = StorageRoom::Collection.find('4dda7761b65245fde100005d')

entries = collection.entry_class.search(:title => 'Hitchhikers Guide to the Galaxy')

puts "Entries with title 'Hitchhikers Guide to the Galaxy':"

entries.resources.each do |entry|
  puts "- #{entry.title} : #{entry[:@url]}"
end