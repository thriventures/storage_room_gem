module StorageRoom
  # The superclass of all the classes that load data from the API
  class Base
    include Attributes
    include HTTParty
    
    headers 'User-Agent' => 'StorageRoom Ruby Gem', 'Accept' => 'application/json', 'Content-Type' => 'application/json'
    format :json

    
    class << self
      # Load an object with the specified URL from the API
      def load(url, parameters = {})
        httparty = get(url, parameters)
        
        handle_critical_response_errors(httparty)
        create_from_api(httparty.parsed_response.first[1])
      end
      
      # Handle known server errors
      def handle_critical_response_errors(httparty) # :nodoc:
        case httparty.response.code
          when '200', '201', '422' then true
          else
            raise StorageRoom::RequestFailed.new("Invalid HTTP Response: #{httparty.response.code}")
        end
      end
      
      # Creates a new object with a hash from the API with a @type attribute
      def create_from_api(hash)  # :nodoc:
        type = hash['@type']
        
        object = case type
          when 'Array' then Array.new
          when 'Collection' then Collection.new
          else
            StorageRoom.class_for_name(type.classify).new
        end
        
        object.set_from_api(hash)
        object
      end
      
      # Find out if a key is user-defined or meta-data (begins with @)      
      def meta_data?(key) 
        key[0...1] == '@'
      end            
    end
    
    # Reload an object from the API. Optionally pass an URL.
    def reload(url = nil, parameters = {})
      httparty = self.class.get(url || self[:@url], parameters)
      set_from_api(httparty.parsed_response.first[1])
      true
    end
       
    # Returns the remote URL of the object        
    def url
      self[:@url]
    end

  end
end