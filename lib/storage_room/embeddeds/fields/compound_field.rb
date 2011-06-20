module StorageRoom
  
  class CompoundField < Field
    def add_to_entry_class(klass) # :nodoc:
      super
      klass.send(:one, identifier)
    end
    
  end
end