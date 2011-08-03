#!/usr/bin/env ruby -rubygems

require File.join(File.dirname(__FILE__), 'authentication')

class Guidebook < StorageRoom::Entry
  before_create :log_before_create
  after_create :log_after_create
  
  before_save :log_before_save
  
  before_destroy :log_before_destroy
  
  def log_before_create
    puts "Before create '#{title}'"
  end
  
  def log_after_create
    puts "After create '#{title}'"
  end
  
  def log_before_save
    puts "Before save '#{title}'"
  end
  
  def log_before_destroy
    puts "Before destroy '#{title}'"
  end
end

guidebook_collection = StorageRoom::Collection.find('4e1e9c234250712eba00005f')

guidebook = Guidebook.new(:title => 'Bar')

guidebook.save

guidebook.destroy
