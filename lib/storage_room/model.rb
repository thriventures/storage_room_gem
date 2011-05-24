module StorageRoom
  # Abstract superclass for classes that can persist to the remote servers
  class Model < Base
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
        raise StorageRoom::AbstractMethod.new
      end
      
      def show_path(id) # :nodoc:
        raise StorageRoom::AbstractMethod.new
      end
      
      def json_name  # :nodoc:
        raise StorageRoom::AbstractMethod.new
      end
    end
    
    # Create a new model and set its attributes
    def initialize(attributes={})     
      @new_record = true
      @errors = []
      
      super
    end
    
    # Set the attributes of the model from the API
    def set_from_api(attributes)
      super
      @new_record = false
      
      self.attributes
    end
    
    # Reset the model to its default state
    def reset!
      super
      @new_record = true
      @errors = []
      true
    end
    
    # Has this model been saved to the API already?
    def new_record?
      @new_record ? true : false
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
      httparty = self.class.put(url, :body => to_json)
      handle_save_response(httparty)
    end
    
    # Delete an existing model on the server
    def destroy
      return false if new_record?
      
      httparty = self.class.delete(url)
      self.class.handle_critical_response_errors(httparty)
      
      true
    end
    
    # Is the model valid or were there validation errors on the server?
    def valid?
      self.errors.empty?
    end
    
    def as_json(args = {}) # :nodoc:
      {self.class.json_name => self.attributes.reject{|k, v| self.class.meta_data?(k) && k.to_s != '@version'}}
    end
    
    # The validation errors that were returned by the server
    def errors
      @errors ||= []
    end
    
    # ===================
    # = Private Methods =
    # ===================
    
    private
      def handle_save_response(httparty) # :nodoc:
        self.class.handle_critical_response_errors(httparty)
        
        if httparty.response.code == '200' || httparty.response.code == '201'
          self.set_from_api(httparty.parsed_response.first[1])
          true
        else
          @errors = httparty.parsed_response['error']['message']
          false
        end
      end
      
  end
end