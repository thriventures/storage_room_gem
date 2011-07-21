$:.unshift(File.dirname(__FILE__)) unless
	$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

begin; require 'rubygems'; rescue LoadError; end

require 'httparty'
require 'mime/types'
require 'base64'
require 'active_support/all' 
require 'storage_room/extensions/const_defined'

require 'storage_room/plugins'

module StorageRoom  
  class AbstractMethodError      < RuntimeError; end
  class RequestFailedError       < RuntimeError; end
  class ResourceNotLoadedError   < RuntimeError; end
  class ClassNotFoundError       < RuntimeError; end
  class OptimisticLockingError   < RuntimeError; end
  
  autoload :Plugins,                  'storage_room/plugins'
  autoload :Accessors,                'storage_room/accessors'
  autoload :Proxy,                    'storage_room/proxy'
  autoload :IdentityMap,              'storage_room/identity_map'
  
  autoload :Resource,                 'storage_room/resource'
  autoload :Model,                    'storage_room/model'
  autoload :Array,                    'storage_room/array'
  autoload :WebhookCall,              'storage_room/webhook_call'

  autoload :Embedded,                 'storage_room/embedded'
  
  autoload :Collection,               'storage_room/models/collection'
  autoload :Entry,                    'storage_room/models/entry'
  autoload :DeletedEntry,             'storage_room/models/deleted_entry'

  autoload :Field,                    'storage_room/embeddeds/field'  
  
  autoload :AtomicField,              'storage_room/embeddeds/fields/atomic_field'  
  autoload :StringField,              'storage_room/embeddeds/fields/atomic/string_field'  
  autoload :TimeField,                'storage_room/embeddeds/fields/atomic/time_field'  
  autoload :IntegerField,             'storage_room/embeddeds/fields/atomic/integer_field'  
  autoload :FloatField,               'storage_room/embeddeds/fields/atomic/float_field'  
  autoload :DateField,                'storage_room/embeddeds/fields/atomic/date_field'  
  autoload :BooleanField,             'storage_room/embeddeds/fields/atomic/boolean_field'  
  autoload :ArrayField,               'storage_room/embeddeds/fields/atomic/array_field'
  autoload :JsonField,                'storage_room/embeddeds/fields/atomic/json_field'
    
  autoload :CompoundField,            'storage_room/embeddeds/fields/compound_field'  
  autoload :AttachmentField,          'storage_room/embeddeds/fields/compound/attachment_field'
  autoload :FileField,                'storage_room/embeddeds/fields/compound/file_field'
  autoload :ImageField,               'storage_room/embeddeds/fields/compound/image_field'
  autoload :LocationField,            'storage_room/embeddeds/fields/compound/location_field'
  
  autoload :AssociationField,         'storage_room/embeddeds/fields/association_field'  
  autoload :OneAssociationField,      'storage_room/embeddeds/fields/associations/one_association_field'  
  autoload :ManyAssociationField,     'storage_room/embeddeds/fields/associations/many_association_field'  
  
  autoload :File,                     'storage_room/embeddeds/file'
  autoload :Image,                    'storage_room/embeddeds/image'
  autoload :Location,                 'storage_room/embeddeds/location'
  autoload :ImageVersion,             'storage_room/embeddeds/image_version'
  autoload :WebhookDefinition,        'storage_room/embeddeds/webhook_definition'


  class << self
    attr_reader :api_key, :user_agent, :account_id, :ssl, :proxy_server, :proxy_port
    attr_accessor :debug
    
    # Authenticate once before making any requests with your account id and the application's api key
    def authenticate(account_id, api_key)
      Resource.basic_auth(api_key, 'X')
      @api_key = api_key
      @account_id = account_id
      update_uri
    end
    
    # Change the user agent that is sent with all requests
    def user_agent=(agent)
      Resource.headers.merge!('User-Agent' => agent)
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
    
    # Hash of all mappings from an Entry's @type to a local Ruby class, if a mapping doesn't exist a class name will be created automatically
    def entry_class_mappings
      @entry_class_mappings ||= {}
    end
    
    # Add a new mapping
    def add_entry_class_mapping(name, class_name)
      self.entry_class_mappings[name] = class_name.to_s
    end
    
    def entry_class_for_name(name) #:nodoc:
      self.entry_class_mappings[name] || name.gsub(/\s+/, "").classify
    end
    
    def version
      @version ||= ::File.read(::File.expand_path(::File.join(::File.dirname(__FILE__), '..', 'VERSION')))
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
      Resource.http_proxy(server, port)
    end
    
    # Return a Ruby class for a StorageRoom type
    def class_for_name(name)     
      name_with_mapping = entry_class_for_name(name)
      
      begin
        if StorageRoom.is_constant_defined?(name_with_mapping)
          return "StorageRoom::#{name_with_mapping}".constantize
        end
      rescue NameError # could contain spaces etc.
      end
        
      if Object.is_constant_defined?(name_with_mapping)
        name_with_mapping.constantize
      else
        raise ClassNotFoundError.new("Unknown class: #{name}")
      end
    end
    
    def log(msg) #:nodoc:
      puts("[DEBUG] #{msg}") if debug
    end
    
    private
    
      def update_uri
        protocol = self.ssl == true ? 'https' : 'http'
      
        url = Resource.base_uri("#{protocol}://#{self.server}/accounts/#{self.account_id}")
      end
    
  end
end
