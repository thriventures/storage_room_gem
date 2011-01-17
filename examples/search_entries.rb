#!/usr/bin/env ruby -rubygems

require File.dirname(__FILE__) + '/authentication'

collection = StorageRoom::Collection.find('guidebooks')

entries = collection.entry_class.search(:title => 'Name 2')

puts "Entries with title 'Name 2':"

entries.resources.each do |entry|
  puts "- #{entry[:title]}"
end