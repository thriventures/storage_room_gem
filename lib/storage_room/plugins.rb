# encoding: UTF-8

module StorageRoom
  module Plugins
    include ActiveSupport::DescendantsTracker

    def plugins
      @plugins ||= []
    end

    def plugin(mod)
      include mod
      direct_descendants.each {|model| model.send(:include, mod) }
      plugins << mod
    end

    def included(base = nil, &block)
      direct_descendants << base if base
      super
    end
  end
end
