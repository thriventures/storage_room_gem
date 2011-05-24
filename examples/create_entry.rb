#!/usr/bin/env ruby -rubygems

require File.dirname(__FILE__) + '/authentication'

# fetch the collection first
collection = StorageRoom::Collection.find('4ddaf68b4d085d374a000003')

entry2 = collection.entry_class.new(:title => 'Bar', :price => 2.23)

if entry2.save
  puts "Entry saved"
else
  puts "Entry could not be saved: #{entry2.errors.join(', ')}"
end