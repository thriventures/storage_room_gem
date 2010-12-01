#!/usr/bin/env ruby -rubygems

require File.dirname(__FILE__) + '/authentication'

collection = StorageRoom::Collection.find('guidebooks')

entry = collection.entries.resources.first

entry[:name] = 'Foobar'

if entry.save
  puts "Entry saved"
else
  puts "Entry could not be saved: #{entry.errors.join(', ')}"
end