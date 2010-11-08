#!/usr/bin/env ruby -rubygems

require File.dirname(__FILE__) + '/authentication'

collection = StorageRoom::Collection.find('guidebooks')

resource = collection.resources.items.first

resource.destroy

puts "Destroyed #{resource[:name]}"