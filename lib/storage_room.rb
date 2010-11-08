$:.unshift(File.dirname(__FILE__)) unless
	$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

begin; require 'rubygems'; rescue LoadError; end

require 'httparty'
require 'activesupport' 


module StorageRoom
  class AbstractMethod < RuntimeError; end
  class RequestFailed < RuntimeError; end
  
  autoload :Attributes,     'storage_room/attributes'
  
  autoload :Base,           'storage_room/base'
  autoload :Model,          'storage_room/model'
  autoload :Array,          'storage_room/array'
  autoload :Field,          'storage_room/field'
  autoload :Embedded,          'storage_room/embedded'
  
  autoload :Collection,     'storage_room/models/collection'
  autoload :Resource,       'storage_room/models/resource'
  
  autoload :File,           'storage_room/embeddeds/file'
  autoload :Location,       'storage_room/embeddeds/location'


  class << self
    attr_reader :api_key
    attr_reader :user_agent
    attr_reader :account_id
    attr_reader :ssl
    attr_reader :proxy_server
    attr_reader :proxy_port
  
    def authenticate(account_id, api_key)
      Base.basic_auth(api_key, 'X')
      @api_key = api_key
      @account_id = account_id
      update_uri
    end
    
    def user_agent=(agent)
      Base.headers.merge!('User-Agent' => agent)
      @user_agent = agent
    end

    def server=(server)
      @server = server
      update_uri
    end
    
    def server
      @server || 'api.storageroomapp.com'
    end
        
    def ssl=(ssl)
      @ssl = ssl
      update_uri
    end
    
    def http_proxy(server, port)
      @proxy_server = server
      @proxy_port = port
      Base.http_proxy(server, port)
    end
    
    def update_uri
      protocol = self.ssl == true ? 'https' : 'http'
      
      Base.base_uri "#{protocol}://#{self.server}/accounts/#{self.account_id}"
    end
    
    def class_for_name(name)        
      if StorageRoom.const_defined?(name)  
        "StorageRoom::#{name}".constantize
      elsif Object.const_defined?(name)
        name.constantize
      else
        klass = Class.new(Resource) 
        Object.const_set(name, klass)
        
        klass
      end
    end
    
  end
end