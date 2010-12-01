#!/usr/bin/env ruby -rubygems

require File.dirname(__FILE__) + '/authentication'

collections = StorageRoom::Collection.all

puts "Collections:"

collections.resources.each do |collection|
  puts "- #{collection[:name]}"
end