#!/usr/bin/env ruby -rubygems

require File.dirname(__FILE__) + '/authentication'

collection = StorageRoom::Collection.find('4dda7761b65245fde100005d')

entry = collection.entries.resources.first

entry.title = 'Foobar'

if entry.save
  puts "Entry saved"
else
  puts "Entry could not be saved: #{entry.errors.join(', ')}"
end