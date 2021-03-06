module StorageRoom
  # The superclass of all the classes that load data from the API
  class Resource
    include HTTParty
    extend Plugins

    include Accessors
    
    plugin IdentityMap
    
    headers 'User-Agent' => "StorageRoom Ruby Gem (#{StorageRoom.version})", 'Accept' => 'application/json', 'Content-Type' => 'application/json'
    format :json

    class << self            
      # Handle known server errors
      def handle_critical_response_errors(httparty) # :nodoc:
        case httparty.response.code
          when '200', '201', '204', '409', '422' then true
          else
            raise StorageRoom::RequestFailedError.new("Invalid HTTP Response: #{httparty.response.code}")
        end
      end
      
      # Find out if a key is user-defined or meta-data (begins with @)      
      def meta_data?(key) 
        key[0...1] == '@'
      end            
    end
    
    # Reload an object from the API. Optionally pass an URL.
    def reload(url = nil, parameters = {})
      httparty = self.class.get(url || self[:@url], StorageRoom.request_options.merge(parameters))
      hash = httparty.parsed_response.first[1]
      reset!
      set_from_response_data(hash)
      true
    end
    
    # Has the Resource been loaded from the API?
    def loaded?
      self['@url'] ? true : false
    end
       

  end
end