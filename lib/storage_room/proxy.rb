module StorageRoom
  # The Proxy class is used in resource associations to delay loading of a resource for as long as possible.
  # Some method calls are directly forwarded to the resource, for others the resource is loaded first from the webservice
  # and afterwards the call is made.
  # The Proxy tries to be as transparent as possible so that you basically never know that you have a proxy object instead of a real resource.
  class Proxy
    METHODS_WITHOUT_RELOAD = [:reload, :response_data, :loaded?, :class, :set_from_response_data, :present?, :is_a?, :respond_to?, :as_json, :to_hash] # TODO: figure out what other methods might be needed?

    instance_methods.each { |m| undef_method m unless m =~ /^(__|instance_eval|object_id)/ } # http://onestepback.org/index.cgi/Tech/Ruby/BlankSlate.rdoc

    def initialize(object, parameters={})
      @object = object
      @parameters = parameters
    end
    
    def proxy?
      true
    end
    
    def inspect
      if @object.loaded?
        @object.inspect
      else
        "#<#{@object.class} (proxied)>"        
      end
    end
    
    def to_s
      inspect
    end
        
    def _object
      @object
    end
    
    # Forward all method calls to the proxied object, reload if necessary
    def method_missing(method_name, *args, &block)
      if @object.loaded? || METHODS_WITHOUT_RELOAD.include?(method_name)
        # no need to reload
      else
        StorageRoom.log("Reloading #{@object['url']} due to #{method_name}")
        @object.reload(@object['url'], @parameters)
      end

      @object.send(method_name, *args, &block)       
    end
  end
  
end