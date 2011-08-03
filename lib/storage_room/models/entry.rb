module StorageRoom
  class Entry < Model
    class_inheritable_accessor :collection
    
    before_initialize_from_response_data :load_associated_collections
    
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
      
      # Find multiple Entries by their IDs with one query
      def find_by_ids(*ids)
        find_by_urls(*ids.map{|id| show_path(id)})
      end
      
      # Find multiple Entries by their URLs with one query
      def find_by_urls(*urls)
        search(:@url.in => urls)
      end
    end
    
        
    # The collection of a entry
    def collection
      self.class.collection
    end    
    
    # Has this Entry been trashed?
    def trashed?
      self[:@trash]
    end
    
    def id
      self[:@url] ? self[:@url].split('/').last : nil
    end
    
    protected
      # Fetch all associated Collections before the Entry is initialized from the JSON document
      def load_associated_collections # :nodoc:
        collection.try(:load_associated_collections)
      end
    
  end
end