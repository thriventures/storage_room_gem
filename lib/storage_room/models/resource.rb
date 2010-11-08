module StorageRoom
  class Resource < Model
    class << self                  
      def index_path
        "/collections/#{collection_id}/resources" 
      end
      
      def show_path(resource_id)
        "#{index_path}/#{resource_id}"
      end
      
      def collection_path
        "/collections/#{collection_id}"
      end
      
      def collection_id
        self.name.gsub('StorageRoom::', '').tableize
      end
      
      def json_name
        'resource'
      end
      
      def search_path(parameters = {})
        parameters.present? ? "#{index_path}?#{parameters.to_query}" : index_path
      end
      
      def search(parameters = {})
        Array.load(search_path(parameters))
      end
    end
    
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
    
    def collection
      Collection.load(self[:@collection_url] || self.class.collection_path)
    end
    

  end
end