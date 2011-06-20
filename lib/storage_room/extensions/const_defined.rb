module ConstDefinedExtension
  def is_constant_defined?(const)
    if ::RUBY_VERSION =~ /1.9/
      const_defined?(const, false)
    else
      const_defined?(const)
    end
  end
end

Object.send(:include, ConstDefinedExtension)
Module.send(:include, ConstDefinedExtension)