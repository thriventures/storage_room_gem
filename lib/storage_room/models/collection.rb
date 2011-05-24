module StorageRoom
  # A collection is used to define the structure of a data set. 
  class Collection < Model        
    class << self                  
      def index_path # :nodoc:
        '/collections'
      end
      
      def show_path(collection_id) # :nodoc:
        "#{index_path}/#{collection_id}"
      end
      
      def entries_path(collection_id) # :nodoc:
        "#{show_path(collection_id)}/entries"
      end
      
      def json_name # :nodoc:
        'collection'
      end
    end
    
    # Load all the entries of a collection
    def entries
      Array.load(self[:@entries_url])
    end
    
    # The class of the collection's objects
    def entry_class
      StorageRoom::Entry.class_with_options(self[:name].classify, :collection_path => self.url)
    end

    
  end
end