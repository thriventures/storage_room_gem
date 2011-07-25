module StorageRoom
  module Extensions
    module ConstDefined
      def is_constant_defined?(const)
        if ::RUBY_VERSION =~ /1.9/
          const_defined?(const, false)
        else
          const_defined?(const)
        end
      end
    end
  end
end

class Object
  include StorageRoom::Extensions::ConstDefined
end

class Module
  include StorageRoom::Extensions::ConstDefined
end
