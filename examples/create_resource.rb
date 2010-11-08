#!/usr/bin/env ruby -rubygems

require File.dirname(__FILE__) + '/authentication'

# create a resource without fetching the collection
klass = StorageRoom.class_for_name('Guidebook')
resource1 = klass.new(:name => 'Foo', :price => 1.23)

if resource1.save
  puts "Resource saved"
else
  puts "Resource could not be saved: #{resource1.errors.join(', ')}"
end

# fetch the collection first
collection = StorageRoom::Collection.find('guidebooks')

resource2 = collection.resource_class.new(:name => 'Bar', :price => 2.23)

if resource2.save
  puts "Resource saved"
else
  puts "Resource could not be saved: #{resource2.errors.join(', ')}"
end