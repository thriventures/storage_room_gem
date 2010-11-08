module StorageRoom
  module Attributes
    def initialize(attributes={})     
      self.attributes = attributes
    end
    
    def set_from_api(attributes)
      reset!
      
      self.attributes = attributes
    end
        
    def [](name)
      self.attributes[name]
    end
    
    def []=(name, value)
      self.attributes[name] = value
    end
    
    def attributes
      @attributes ||= Hash.new.with_indifferent_access
    end
    
    def attributes=(hash = {})
      hash.each do |k, v|
        self.attributes[k] = v
      end
    end
    
    def reset!
      @attributes = Hash.new.with_indifferent_access
    end
    
  end
  
end