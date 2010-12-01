#!/usr/bin/env ruby -rubygems

require File.dirname(__FILE__) + '/authentication'

collection = StorageRoom::Collection.find('guidebooks')

entries = collection.entry_class.search(:name => 'Bar')

puts "Entries with name 'Bar':"

entries.resources.each do |entry|
  puts "- #{entry[:name]}"
end