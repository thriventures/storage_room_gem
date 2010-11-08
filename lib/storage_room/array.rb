module StorageRoom
  class Array < Base
    attr_accessor :items
    
    class << self      

    end
    
    
    def initialize(attributes = {})
      self.items = []
      super
    end
    
    def set_from_api(attributes)
      super(attributes)
                  
      self.items = attributes['items'].map{|item| self.class.create_from_api(item)} # transform hashes to real objects
      attributes.delete('items')  
    end
    
    def reset!
      super
      @items = []
    end
    
    def load_next_page!
      if self[:@next_page].present?
        reload(self[:@next_page]) 
        true
      else
        false
      end
    end
    
    # Replace the Collection with the privious page of elements if there is one
    def load_previous_page!
      if self[:@previous_page].present?
        reload(self[:@previous_page]) 
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
    
    # Iterate over all items with pagination
    def each_page_each_item(args={})
      self.each_page(args) do |page|
        page.items.each do |item|
          yield(item)
        end
      end
    end
        
  end
end