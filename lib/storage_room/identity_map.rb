module StorageRoom
  # With inspiration from John Nunemaker's MongoMapper
  module IdentityMap
    extend ActiveSupport::Concern
    
    included do
      IdentityMap.models << self
    end
    
    def self.models
      @models ||= ::Set.new
    end

    def self.clear
      models.each { |m| m.identity_map.clear }
    end
    
    module ClassMethods
      def inherited(descendant)
        descendant.identity_map = identity_map
        super
      end
      
      # Load an object from the identity map if the key (URL) exists
      def load(url, parameters = {})
        return nil if url.nil?
        
        if identity_map_on? && object = identity_map[url]
          StorageRoom.log("Loaded #{object} (#{url}) from identity map (load)")
          object
        else
          super
        end
      end

      # Load an object from the identity map or create it
      def new_from_response_data(response_data)        
        url = response_data['@url'] || response_data['url']
        object = url ? identity_map[url] : nil
                
        if object.present? && identity_map_on?
          if object.loaded? && response_data_is_association?(response_data)
            StorageRoom.log("Loaded #{object} (#{url}) from identity map (new_from_response_data)")
          else
            StorageRoom.log("Loaded #{object} (#{url}) from identity map and updated attributes (new_from_response_data)")
            object.set_from_response_data(response_data) 
          end
        else
          object = super
          if identity_map_on? && url.present? && object.is_a?(Model)
            identity_map[url] = object 
            StorageRoom.log("Storing #{url} in identity map: #{object}")
          end
        end
        
        object
      end

      def identity_map
        @identity_map ||= {}
      end

      def identity_map=(v)
        @identity_map = v
      end
      
      def identity_map_status
        defined?(@identity_map_status) ? @identity_map_status : true
      end

      def identity_map_on
        @identity_map_status = true
      end

      def identity_map_off
        @identity_map_status = false
      end

      def identity_map_on?
        identity_map_status
      end

      def identity_map_off?
        !identity_map_on?
      end

      def without_identity_map(&block)
        identity_map_off
        yield
      ensure
        identity_map_on
      end
      
    end
    
    module InstanceMethods
      def identity_map
        self.class.identity_map
      end
      
      def in_identity_map?
        return false if self[:@url].blank?
        identity_map.include?(self[:@url])
      end
      
      def create(*args)
        if result = super
          identity_map[self[:@url]] = self if self.class.identity_map_on?
        end
        result
      end
      
      def destroy 
         identity_map.delete(self[:@url]) if self.class.identity_map_on?
         super
       end
      
    end
  end
end

