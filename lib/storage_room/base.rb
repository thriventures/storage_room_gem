module StorageRoom
  class Base
    include Attributes
    include HTTParty
    
    headers 'User-Agent' => 'StorageRoom Ruby Gem', 'Accept' => 'application/json', 'Content-Type' => 'application/json'
    format :json

    
    class << self
      def load(url, parameters = {})
        httparty = get(url, parameters)
        
        handle_critical_response_errors(httparty)
        create_from_api(httparty.parsed_response.first[1])
      end
      
      def handle_critical_response_errors(httparty)
        case httparty.response.code
          when '200', '201', '422' then true
          else
            raise StorageRoom::RequestFailed.new("Invalid HTTP Response: #{httparty.response.code}")
        end
      end
      
      def create_from_api(hash) 
        type = hash['@type']
        
        object = case type
          when 'Array' then Array.new
          when 'Collection' then Collection.new
          else
            StorageRoom.class_for_name(type).new
        end
        
        object.set_from_api(hash)
        object
      end
            
      def meta_data?(key)
        key[0...1] == '@'
      end            
    end
    
    def reload(url = nil, parameters = {})
      httparty = self.class.get(url || self[:@url], parameters)
      set_from_api(httparty.parsed_response.first[1])
      true
    end
            
    def url
      self[:@url]
    end

  end
end