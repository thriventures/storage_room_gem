module StorageRoom
  # A container object that contains many models (collections or entries)
  class Array < Resource
    many :resources
            
    # Replaces the objects content with the next page of the array if a next page exists
    def load_next_page!
      if self[:@next_page_url].present?
        reload(self[:@next_page_url]) 
        true
      else
        false
      end
    end
    
    # Replace the Collection with the privious page of elements if there is one
    def load_previous_page!
      if self[:@previous_page_url].present?
        reload(self[:@previous_page_url]) 
        true
      else
        false
      end    
    end
    
    
    # Iterate over all pages
    def each_page(args={})
      begin
        yield(self)
      end while(args[:reverse] == true ? load_previous_page! : load_next_page!)
    end
    
    # Iterate over all resources with pagination
    def each_page_each_item(args={})
      self.each_page(args) do |page|
        page.resources.each do |item|
          yield(item)
        end
      end
    end
        
  end
end