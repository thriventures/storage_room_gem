module StorageRoom
  
  # Module that contains attributes methods shared between StorageRoom::Base and StorageRoom::Embedded
  module Attributes
    # Optionally pass attributes to set up the object
    def initialize(attributes={})     
      self.attributes = attributes
    end
    
    # Set the attributes of an object with a hash from the API
    def set_from_api(attributes)
      reset!
      
      self.attributes = attributes
    end
        
    # Shortcut to get an attribute. 
    def [](name)
      self.attributes[name]
    end
    
    # Shortcut to set an attribute
    def []=(name, value)
      self.attributes[name] = value
    end
    
    # Return all of the objects attributes
    def attributes
      @attributes ||= Hash.new.with_indifferent_access
    end
    
    # Set the objects attributes with a hash. Only attributes passed in the hash are changed, existing ones are not overridden.
    def attributes=(hash = {})
      hash.each do |k, v|
        self.attributes[k] = v
      end
    end
    
    # Reset an object to its initial state with all attributes unset
    def reset!
      @attributes = Hash.new.with_indifferent_access
    end
    
  end
  
end