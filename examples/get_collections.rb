#!/usr/bin/env ruby -rubygems

require File.join(File.dirname(__FILE__), 'authentication')

collections = StorageRoom::Collection.all

puts "Collections:"

collections.resources.each do |collection| # The array returned by Collection.all contains all the items in the resources key
  puts "- #{collection.name}"
end