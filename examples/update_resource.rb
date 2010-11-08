#!/usr/bin/env ruby -rubygems

require File.dirname(__FILE__) + '/authentication'

collection = StorageRoom::Collection.find('guidebooks')

resource = collection.resources.items.first

resource[:name] = 'Foobar'

if resource.save
  puts "Resource saved"
else
  puts "Resource could not be saved: #{resource.errors.join(', ')}"
end