module StorageRoom
  # Abstract superclass for classes that can persist to the remote servers
  class Model < Resource    
    class << self
      # Create a new model with the passed attributes
      def create(attributes={})
        entry = new(attributes)
        entry.create
        entry
      end
      
      # Get all models (could be paginated)
      def all
        load(index_path)
      end
      
      # Find a model with the specified id
      def find(id)
        load(show_path(id))
      end
      
      #       
      def index_path # :nodoc:
        raise StorageRoom::AbstractMethodError.new
      end
      
      def show_path(id) # :nodoc:
        raise StorageRoom::AbstractMethodError.new
      end
      
      def json_name  # :nodoc:
        raise StorageRoom::AbstractMethodError.new
      end
    end
    
    # Create a new model and set its attributes
    def initialize(attributes={})     
      @errors = []
      
      super
    end
        
    # Reset the model to its default state
    def reset!
      super
      @errors = []
      true
    end
    
    # Has this model been saved to the API already?
    def new_record?
      self['@version'] ? false : true
    end
    
    # Create a new model or update an existing model on the server
    def save
      new_record? ? create : update
    end
    
    # Create a new model on the server
    def create
      return false unless new_record?
      httparty = self.class.post(self.class.index_path, :body => to_json)
      handle_save_response(httparty)
    end
    
    # Update an existing model on the server
    def update
      return false if new_record?
      httparty = self.class.put(self[:@url], :body => to_json)
      handle_save_response(httparty)
    end
    
    # Delete an existing model on the server
    def destroy
      return false if new_record?
      
      httparty = self.class.delete(self[:@url])
      self.class.handle_critical_response_errors(httparty)
      
      true
    end
    
    # Is the model valid or were there validation errors on the server?
    def valid?
      self.errors.empty?
    end
    
    # ActiveSupport caused problems when using as_json, so using to_hash
    def to_hash(args = {}) # :nodoc:
      args ||= {}
      
      if args[:nested]
        {'url' => self[:@url] || self[:url]}
      else
        hash = super
        hash.merge!('@version' => self['@version']) unless new_record?
        {self.class.json_name => hash}        
      end
    end
    
    # The validation errors that were returned by the server
    def errors
      @errors ||= []
    end
    
    protected
      def handle_save_response(httparty) # :nodoc:
        self.class.handle_critical_response_errors(httparty)
        
        if httparty.response.code == '200' || httparty.response.code == '201'
          self.set_from_response_data(httparty.parsed_response.first[1])
          @errors = []
          true
        elsif httparty.response.code == '409' # optimistic locking
          raise OptimisticLockingError.new("The Model has been updated by somebody else")
        else
          @errors = httparty.parsed_response['error']['message']
          false
        end
      end

      
  end
end