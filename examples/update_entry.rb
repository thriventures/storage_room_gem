#!/usr/bin/env ruby -rubygems

require File.dirname(__FILE__) + '/authentication'

collection = StorageRoom::Collection.find('4d960916ba05617333000005')

entry = collection.entries.resources.first

entry[:title] = 'Foobar'

if entry.save
  puts "Entry saved"
else
  puts "Entry could not be saved: #{entry.errors.join(', ')}"
end