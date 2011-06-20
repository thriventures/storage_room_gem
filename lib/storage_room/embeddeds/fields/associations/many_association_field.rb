module StorageRoom
  
  class ManyAssociationField < AssociationField
    def add_to_entry_class(klass) # :nodoc:
      super
      klass.send(:many, identifier)
    end
  end
end