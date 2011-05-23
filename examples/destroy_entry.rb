#!/usr/bin/env ruby -rubygems

require File.dirname(__FILE__) + '/authentication'

collection = StorageRoom::Collection.find('4d960916ba05617333000005')

entry = collection.entries.resources.first

entry.destroy

puts "Destroyed #{entry[:name]}"