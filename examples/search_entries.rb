#!/usr/bin/env ruby -rubygems

require File.dirname(__FILE__) + '/authentication'

collection = StorageRoom::Collection.find('4ddaf68b4d085d374a000003')

entries = collection.entry_class.search(:title => 'Hitchhikers Guide to the Galaxy')

puts "Entries with title 'Hitchhikers Guide to the Galaxy':"

entries.resources.each do |entry|
  puts "- #{entry[:title]} : #{entry.url}"
end