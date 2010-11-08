module StorageRoom
  class Model < Base
    class << self
      def create(attributes={})
        resource = new(attributes)
        resource.create
        resource
      end
      
      def all
        load(index_path)
      end
      
      def find(id)
        load(show_path(id))
      end
            
      def index_path
        raise StorageRoom::AbstractMethod.new
      end
      
      def show_path(id)
        raise StorageRoom::AbstractMethod.new
      end
      
      def json_name
        raise StorageRoom::AbstractMethod.new
      end
    end
    
    def initialize(attributes={})     
      @new_record = true
      @errors = []
      
      super
    end
    
    def set_from_api(attributes)
      super
      @new_record = false
      
      self.attributes
    end
    
    def reset!
      super
      @new_record = true
      @errors = []
      true
    end
    
    def new_record?
      @new_record ? true : false
    end
    
    def save
      new_record? ? create : update
    end
    
    def create
      return false unless new_record?
      httparty = self.class.post(self.class.index_path, :body => to_json)
      handle_save_response(httparty)
    end
    
    def update
      return false if new_record?
      httparty = self.class.put(url, :body => to_json)
      handle_save_response(httparty)
    end
    
    def destroy
      return false if new_record?
      
      httparty = self.class.delete(url)
      self.class.handle_critical_response_errors(httparty)
      
      true
    end
    
    def valid?
      self.errors.empty?
    end
    
    def as_json(args = {})
      {self.class.json_name => self.attributes.reject{|k, v| self.class.meta_data?(k)}}
    end
    
    def errors
      @errors ||= []
    end
    
    # ===================
    # = Private Methods =
    # ===================
    
    private
      def handle_save_response(httparty)
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