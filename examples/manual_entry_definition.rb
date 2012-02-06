#!/usr/bin/env ruby -rubygems

require File.join(File.dirname(__FILE__), 'authentication')

# define the class that's used for Collection with entry_type "Restaurant"
class Restaurant < StorageRoom::Entry
  key :name
  key :body
  key :rating
  
  one :location # A LocationField, any embedded Resource or a To-One Association
  
  many :tags # ArrayField, or a To-Many Association
end