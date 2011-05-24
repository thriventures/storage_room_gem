#!/usr/bin/env ruby -rubygems

require File.dirname(__FILE__) + '/authentication'

collection = StorageRoom::Collection.find('4ddaf68b4d085d374a000003')

entry = collection.entries.resources.first

entry[:title] = 'Foobar'

if entry.save
  puts "Entry saved"
else
  puts "Entry could not be saved: #{entry.errors.join(', ')}"
end