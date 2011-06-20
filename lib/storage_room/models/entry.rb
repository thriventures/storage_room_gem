module StorageRoom
  class Entry < Model
    class_inheritable_accessor :collection
        
    class << self         
      def index_path # :nodoc:
        "#{collection[:@url]}/entries"
      end
            
      def show_path(entry_id) # :nodoc:
        "#{index_path}/#{entry_id}"
      end
            
      def json_name # :nodoc:
        'entry'
      end
      
      def search_path(parameters = {}) # :nodoc:
        parameters.present? ? "#{index_path}?#{parameters.to_query}" : index_path
      end
      
      # Search for objects with specific parameters
      def search(parameters = {})
        Array.load(search_path(parameters))
      end
    end
    
    # The collection of a entry
    def collection
      self.class.collection
    end    

  end
end