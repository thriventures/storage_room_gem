#!/usr/bin/env ruby -rubygems

require File.join(File.dirname(__FILE__), 'authentication')


# fetch the collection first
guidebook_collection = StorageRoom::Collection.find('4dda7761b65245fde100005d')
category_collection  = StorageRoom::Collection.find('4dda7761b65245fde100001a')

category = category_collection.entries.resources.first # find the first category
guidebook = guidebook_collection.entry_class.new(:title => 'Bar', :price => 2.23, :category => category, :tags => ['tag1', 'tag2'])

if guidebook.save # save the guidebook with the associated category
  puts "Guidebook Entry saved (#{guidebook[:@url]})"
else
  puts "Guidebook could not be saved: #{entry2.errors.join(', ')}"
end