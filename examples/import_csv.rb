#!/usr/bin/env ruby -rubygems

require File.dirname(__FILE__) + '/authentication'

require 'faster_csv'

lines = FasterCSV.read(File.dirname(__FILE__) + '/guidebooks.csv') # Exported an Excel file as CSV

lines.slice!(0) # remove header line

klass = StorageRoom.class_for_name('Guidebook')

lines.each do |row|
  guidebook = klass.new(:title => row[0], :price => row[1].to_f)

  if guidebook.save
    puts "Guidebook saved: #{guidebook[:title]}, #{guidebook[:price]}"
  else
    puts "Guidebook could not be saved: #{guidebook.errors.join(', ')}"
  end
end
