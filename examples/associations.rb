#!/usr/bin/env ruby -rubygems

require File.join(File.dirname(__FILE__), 'authentication')

guidebook_collection = StorageRoom::Collection.find('4e1e9c234250712eba00005f')

guidebook_collection.entries.resources.each do |guidebook|
  puts "#{guidebook.title} (#{guidebook.category.try(:name)})"
end