#!/usr/bin/env ruby -rubygems

require File.dirname(__FILE__) + '/authentication'

collection = StorageRoom::Collection.find('guidebooks')

entry = collection.entries.resources.first

entry.destroy

puts "Destroyed #{entry[:name]}"