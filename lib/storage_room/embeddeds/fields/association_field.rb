module StorageRoom
  
  class AssociationField < Field
    key :collection_url
    
    def add_to_entry_class(klass) # :nodoc:
      super
      
      collection
    end
    
    # The target collection of the association field
    def collection
      @collection ||= Collection.load(self.collection_url)
    end
  end
end