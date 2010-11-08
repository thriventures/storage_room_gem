module StorageRoom
  class Collection < Model        
    class << self                  
      def index_path
        '/collections'
      end
      
      def show_path(collection_id)
        "#{index_path}/#{collection_id}"
      end
      
      def resources_path(collection_id)
        "#{show_path(collection_id)}/resources"
      end
      
      def json_name
        'collection'
      end
    end
    
    def resources
      Array.load(self[:@resources_url])
    end
    
    def resource_class
      StorageRoom.class_for_name(self[:identifier].classify)
    end

    
  end
end