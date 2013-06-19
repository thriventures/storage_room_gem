module StorageRoom

  # Module that contains attributes methods shared between StorageRoom::Resource and StorageRoom::Embedded
  module Accessors
    extend ActiveSupport::Concern

    included do
      self.send(:extend, ::ActiveModel::Callbacks)
      self.send(:define_model_callbacks, :initialize_from_response_data)
    end

    module ClassMethods
      # Is the passed hash of response data a real object or only an association with a URL but no actual data
      def response_data_is_association?(hash)
        hash.size == 2 && hash.include?('@type') && hash.include?('url')
      end

      # Load an object with the specified URL from the API
      def load(url, parameters = {})
        return nil if url.blank?

        StorageRoom.log("Loading #{url}")
        httparty = get(url, parameters)

        handle_critical_response_errors(httparty)
        new_from_response_data(httparty.parsed_response.first[1])
      end

      # Build an object out of a local file
      def new_from_json_file(path)
        json = ::File.read(path)
        new_from_json_string(json)
      end

      # Build an object out of the POST body
      def new_from_json_string(json_string)
        hash = JSON.parse(json_string)
        new_from_response_data(hash.first[1])
      end

      # Creates a new object of the correct class and initializes it from the response data
      def new_from_response_data(response_data)
        object = StorageRoom.class_for_name(response_data['@type']).new.set_from_response_data(response_data)

        if object.is_a?(Entry) && !object.loaded? && !object.proxy?
          StorageRoom.log("Return  #{response_data['url']} proxied")
          Proxy.new(object)
        else
          object
        end
      end

      # Defines a basic key for a Resource
      def key(name, options = {})
        options.merge!(:type => :key, :default => nil)
        define_attribute_methods(name, options)
      end

      # Defines a to-one association for a Resource (embedded or association)
      def one(name, options = {})
        options.merge!(:type => :one, :default => nil)
        define_attribute_methods(name, options)
      end

      # Defines a to-many association for a Resource (embedded or association)
      def many(name, options = {})
        options.merge!(:type => :many, :default => [])
        define_attribute_methods(name, options)
      end

      # Creates getter and setter for an attribute
      def define_attribute_methods(name, options) # :nodoc:
        define_method name do
          attributes[name] || options[:default]
        end

        define_method "#{name}=" do |object|
          attributes[name] = object
        end

        self.attribute_options[name] = options
      end

      def attribute_options
        @attribute_options ||= {}
      end

      def attribute_options_including_superclasses
        hash = attribute_options.dup
        hash.merge!(superclass.attribute_options_including_superclasses) if superclass.respond_to?(:attribute_options_including_superclasses)

        hash
      end
    end

    # Optionally pass attributes to set up the object
    def initialize(hash={})
      self.attributes = hash
    end

    # Shortcut to get an attribute.
    def [](name)
      self.response_data[name]
    end

    # Takes a response data hash, saves it in the record and initializes the class from the response data
    def set_from_response_data(hash)
      self.response_data = hash
      self.initialize_from_response_data
      self
    end

    # Return all of the objects attributes
    def response_data
      @_response_data ||= Hash.new.with_indifferent_access
    end

    # Set the objects attributes with a hash. Only attributes passed in the hash are changed, existing ones are not overridden.
    def response_data=(hash = {})
      response_data.merge!(hash)
    end

    # The attributes as they were defined with key, one, many
    def attributes
      @_attributes ||= Hash.new.with_indifferent_access
    end

    def attributes=(args = {})
      attributes.merge!(args)
    end

    def as_json(args = {}) # :nodoc:
      to_hash(args)
    end

    # ActiveSupport seemed to cause problems when just using as_json, so using to_hash
    def to_hash(args = {}) # :nodoc:
      args ||= {}
      hash = {}

      self.attributes.each do |name, value|
        hash[name] = if value.is_a?(::Array)
          value.map {|x| x.respond_to?(:to_hash) ? call_method_with_optional_parameters(x, :to_hash, :nested => true) : x}
        elsif value.respond_to?(:to_hash)
          call_method_with_optional_parameters(value, :to_hash, :nested => true)
        elsif value.respond_to?(:as_json)
          value.as_json(:nested => true)
        else
          value
        end
      end

      hash
    end

    def inspect # :nodoc:
      body = attributes.map{|k, v| "#{k}: #{attribute_for_inspect(v)}"}.join(', ')
      "#<#{self.class} #{body}>"
    end

    # Reset an object to its initial state with all attributes unset
    def reset!
      @_response_data = Hash.new.with_indifferent_access
      @_attributes = Hash.new.with_indifferent_access
      true
    end

    # Has a Resource been loaded from the API
    def loaded?
      self.response_data.present?
    end

    def proxy? # :nodoc:
      false
    end

    # Compare Resources by comparing their attributes
    def eql?(object)
      self.class.equal?(object.class) && attributes == object.attributes
    end

    alias == eql?

    def hash
      self.class.hash ^ self.attributes.hash
    end

    protected
      # Helper to not call to_hash with the wrong number of arguments
      def call_method_with_optional_parameters(object, method_name, parameters)
        if object.respond_to?(method_name)
          if object.method(method_name).arity == -1
            object.send(method_name, parameters)
          else
            object.send(method_name)
          end
        end
      end

      # Iterate over the response data and initialize the attributes
      def initialize_from_response_data # :nodoc:
        run_callbacks :initialize_from_response_data do
          self.class.attribute_options_including_superclasses.each do |name, options|
            value = if options[:type] == :key
              self[name].blank? ? options[:default] : self[name]
            elsif options[:type] == :one
              hash = self[name.to_s]
              hash && hash['@type'] ? self.class.new_from_response_data(hash) : nil
            elsif options[:type] == :many
              response_data[name] && response_data[name].map{|hash| self.class.new_from_response_data(hash)} || []
            else
              raise "Invalid type: #{options[:type]}"
            end

            send("#{name}=", value)
          end
        end
      end

      def ensure_loaded # :nodoc:
        if loaded?
          yield if block_given?
        else
          raise StorageRoom::ResourceNotLoadedError
        end
      end

      def attribute_for_inspect(value) # :nodoc:
        if value.is_a?(String) && value.length > 50
          "#{value[0..50]}...".inspect
        elsif value.is_a?(Date) || value.is_a?(Time)
          %("#{value.iso8601}")
        else
          value.inspect
        end
      end
  end




end