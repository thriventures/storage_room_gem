module StorageRoom
  
  class Field < Embedded
    key :name
    key :identifier
    
    key :interface
    key :hint

    key :input_type

    key :required
    key :unique

    key :maximum_length
    key :minimum_length

    key :minimum_number
    key :maximum_number

    key :minimum_size
    key :maximum_size
    
    def add_to_entry_class(klass) # :nodoc:
      
    end
    
  end
end