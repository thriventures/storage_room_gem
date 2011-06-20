module StorageRoom
  
  class AtomicField < Field
    key :default_value

    key :choices
    key :include_blank_choice
    
    def add_to_entry_class(klass) # :nodoc:
      super
      klass.send(:key, identifier)
    end
    
  end
end