#!/usr/bin/env ruby -rubygems

require File.dirname(__FILE__) + '/authentication'

# create a entry without fetching the collection
klass = StorageRoom.class_for_name('Guidebook')
entry1 = klass.new(:title => 'Foo', :price => 1.23)

if entry1.save
  puts "Entry saved"
else
  puts "Entry could not be saved: #{entry1.errors.join(', ')}"
end

# fetch the collection first
collection = StorageRoom::Collection.find('guidebooks')

entry2 = collection.entry_class.new(:title => 'Bar', :price => 2.23)

if entry2.save
  puts "Entry saved"
else
  puts "Entry could not be saved: #{entry2.errors.join(', ')}"
end