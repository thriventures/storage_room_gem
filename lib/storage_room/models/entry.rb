module StorageRoom
  class Entry < Model
    class_inheritable_accessor :collection_path
    
    class << self   
      def class_with_options(name, options = {})
        # TODO_SK: check options
        
        klass = StorageRoom.class_for_name(name)
        
        klass.collection_path = options[:collection_path]
        
        klass
      end
      
      def index_path
        "#{collection_path}/entries"
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
    
    # Sets a entry with a hash from the API.
    def set_from_api(attributes)
      super(attributes)
                  
      self.attributes.each do |k, v|
        if v.is_a?(Hash) && v[:@type].present?
          object = StorageRoom.class_for_name(v[:@type]).new
          object.set_from_api(v)
          self.attributes[k] = object
        end
      end
      
      self.attributes
    end
    
    # The collection of a entry
    def collection
      Collection.load(self[:@collection_url] || self.class.collection_path)
    end
    

  end
end