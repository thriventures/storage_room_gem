#!/usr/bin/env ruby -rubygems

require File.join(File.dirname(__FILE__), 'authentication')

collection = StorageRoom::Collection.find('4dda7761b65245fde100005d')
Book = collection.entry_class

entries = Book.search(:title => 'Hitchhikers Guide to the Galaxy')

puts "Entries with title 'Hitchhikers Guide to the Galaxy':"

entries.resources.each do |entry|
  puts "- #{entry.title} : #{entry[:@url]}"
end

# Some more example for searches

Book.search(:tags => ['fiction', 'future', 'novel']) # search for Books *with any* of these tags
Book.search(:tags.all => ['french', 'fiction']) # search for Books *with all* of these tags
Book.search(:tags.nin => ['german', 'chinese']) # search for Books *without any* of these tags

Book.find_by_urls('book_url1', 'book_url2', 'book_url3') # load multiple Books at once by their @url