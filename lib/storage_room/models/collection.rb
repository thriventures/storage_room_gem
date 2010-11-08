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
      
      def resources_path(collection_id) # :nodoc:
        "#{show_path(collection_id)}/resources"
      end
      
      def json_name # :nodoc:
        'collection'
      end
    end
    
    # Load all the resources of a collection
    def resources
      Array.load(self[:@resources_url])
    end
    
    # The class of the collection's objects
    def resource_class
      StorageRoom.class_for_name(self[:identifier].classify)
    end

    
  end
end