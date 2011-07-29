module StorageRoom
  # A collection is used to define the structure of a data set. 
  class Collection < Model      
    key :name
    key :primary_field_identifier
    
    many :fields
    many :webhook_definitions
    
    class << self                  
      def index_path # :nodoc:
        "#{Resource.base_uri}/collections"
      end
      
      def show_path(collection_id) # :nodoc:
        "#{index_path}/#{collection_id}"
      end
            
      def json_name # :nodoc:
        'collection'
      end
    end
    
    # The class name of the collection's entries, can be overridden with a mapping
    def entry_class_name
      ensure_loaded { StorageRoom.entry_class_for_name(name)}
    end
    
    # The class for the collection's entries
    def entry_class
      require_initialized_entry_class do 
        self.entry_class_name.constantize
      end
    end
    
    # Load all the entries of a collection
    def entries
      require_initialized_entry_class do 
        Array.load(self[:@entries_url])
      end
    end
    
    # Load all deleted entries of a collection
    def deleted_entries
      Array.load(self[:@deleted_entries_url])
    end
    
    # The field with a specific identifier
    def field(identifier)
      ensure_loaded do
        fields.each do |f|
          return f if f.identifier == identifier
        end
      end
      
      nil
    end
    
    protected   
      def initialize_from_response_data
        super
        require_initialized_entry_class
      end
     
      def initialize_entry_class      
        name = self.entry_class_name

        klass = if Object.is_constant_defined?(name.to_sym)  
          name.constantize.tap{|k| raise "Class '#{name}' must inherit from StorageRoom::Entry" unless k.ancestors.include?(Entry)}
        else
          klass = Class.new(Entry) 
          Object.const_set(name, klass)
          klass
        end

        klass.collection = self
        
        fields.each do |field|
          field.add_to_entry_class(klass)
        end
      
        true
      end
    
      def deconstruct_entry_class
        if Object.is_const_defined?(self.entry_class_name.to_sym)
          Object.send(:remove_const, self.entry_class_name) 
        end

        true
      end

      def recreate_entry_class
        self.deconstruct_entry_class
        self.initialize_entry_class
      end

      def require_initialized_entry_class
        ensure_loaded do
          self.initialize_entry_class
          yield if block_given?
        end
      end
  end
end