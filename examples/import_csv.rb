#!/usr/bin/env ruby -rubygems

require File.dirname(__FILE__) + '/authentication'

require "csv" # faster_csv (ruby 1.9)

lines = CSV.read(File.dirname(__FILE__) + '/guidebooks.csv') # Exported an Excel file as CSV

lines.slice!(0) # remove header line

collection = StorageRoom::Collection.find('4ddaf68b4d085d374a000003')
klass = collection.entry_class

lines.each do |row|
  guidebook = klass.new(:title => row[0], :price => row[1].to_f)

  if guidebook.save
    puts "Guidebook saved: #{guidebook[:title]}, #{guidebook[:price]}"
  else
    puts "Guidebook could not be saved: #{guidebook.errors.join(', ')}"
  end
end
