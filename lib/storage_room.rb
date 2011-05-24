$:.unshift(File.dirname(__FILE__)) unless
	$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

begin; require 'rubygems'; rescue LoadError; end

require 'httparty'
require 'active_support/all' 


module StorageRoom
  class AbstractMethod < RuntimeError; end
  class RequestFailed < RuntimeError; end
  
  autoload :Attributes,     'storage_room/attributes'
  
  autoload :Base,           'storage_room/base'
  autoload :Model,          'storage_room/model'
  autoload :Array,          'storage_room/array'
  autoload :Field,          'storage_room/field'
  autoload :Embedded,       'storage_room/embedded'
  
  autoload :Collection,     'storage_room/models/collection'
  autoload :Entry,       'storage_room/models/entry'
  
  autoload :File,           'storage_room/embeddeds/file'
  autoload :Location,       'storage_room/embeddeds/location'


  class << self
    attr_reader :api_key
    attr_reader :user_agent
    attr_reader :account_id
    attr_reader :ssl
    attr_reader :proxy_server
    attr_reader :proxy_port
    
    # Authenticate once before making any requests with your account id and the application's api key
    def authenticate(account_id, api_key)
      Base.basic_auth(api_key, 'X')
      @api_key = api_key
      @account_id = account_id
      update_uri
    end
    
    # Change the user agent that is sent with all requests
    def user_agent=(agent)
      Base.headers.merge!('User-Agent' => agent)
      @user_agent = agent
    end
    
    # Change the server to connect to. This should only be relevant for developers of the library.
    def server=(server) #:nodoc:
      @server = server
      update_uri
    end
    
    def server #:nodoc:
      @server || 'api.storageroomapp.com'
    end
    
    # Requests are made with SSL
    def ssl=(ssl)
      @ssl = ssl
      update_uri
    end
    
    # Set an HTTP proxy server
    def http_proxy(server, port)
      @proxy_server = server
      @proxy_port = port
      Base.http_proxy(server, port)
    end
    
    # Return a Ruby class for a StorageRoom type
    def class_for_name(name) 
      is_ruby_19 = method(:const_defined?).arity == 1 # ruby 1.9 check
      
      if is_ruby_19 ? StorageRoom.const_defined?(name)  : StorageRoom.const_defined?(name, false)
        "StorageRoom::#{name}".constantize
      elsif is_ruby_19 ? Object.const_defined?(name) : Object.const_defined?(name, false)
        name.constantize
      else
        klass = Class.new(Entry) 
        Object.const_set(name, klass)
        
        klass
      end
    end
    
    private
    
      def update_uri
        protocol = self.ssl == true ? 'https' : 'http'
      
        Base.base_uri "#{protocol}://#{self.server}/accounts/#{self.account_id}"
      end
    
  end
end