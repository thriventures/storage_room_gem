#!/usr/bin/env ruby -rubygems

require File.join(File.dirname(__FILE__), 'authentication')

collection = StorageRoom::Collection.find('4d960916ba05617333000005')

puts "Nested Loops:\n\n"

# Iterate over all pages of entries with nested loops
collection.entries.each_page do |array|
  puts "== Page: #{array[:@page]} / #{array[:@pages]}"
  array.resources.each do |entry|
    puts "Entry: #{entry.name}"
  end
end

puts "Single helper:\n\n"

# Iterate over all entries on all pages with one helper
collection.entries.each_page_each_resource do |entry|
  puts "Entry: #{entry.name}"
end