#!/usr/bin/env ruby -rubygems

require File.dirname(__FILE__) + '/authentication'

collection = StorageRoom::Collection.find('guidebooks')

resources = collection.resource_class.search(:name => 'Bar')

puts "Resources with name 'Bar':"

resources.items.each do |resource|
  puts "- #{resource[:name]}"
end