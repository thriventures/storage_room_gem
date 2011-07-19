#!/usr/bin/env ruby -rubygems

require File.join(File.dirname(__FILE__), 'authentication')

collection = StorageRoom::Collection.find('4dda7761b65245fde100005d')

entry = collection.entries.resources.first

entry.destroy

puts "Destroyed #{entry.title}"