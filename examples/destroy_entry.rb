#!/usr/bin/env ruby -rubygems

require File.dirname(__FILE__) + '/authentication'

collection = StorageRoom::Collection.find('4ddaf68b4d085d374a000003')

entry = collection.entries.resources.first

entry.destroy

puts "Destroyed #{entry[:title]}"