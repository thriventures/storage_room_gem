#!/usr/bin/env ruby -rubygems

require File.dirname(__FILE__) + '/authentication'

collections = StorageRoom::Collection.all

puts "Collections:"

collections.items.each do |collection|
  puts "- #{collection[:name]}"
end