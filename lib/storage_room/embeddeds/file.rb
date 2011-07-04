
module StorageRoom
  # Any file
  class File < Embedded
    key :filename
    key :content_type
    key :data
    key :remove
    
    class << self
      # Create a new File and set attributes from local file
      def new_with_filename(path)
        new.tap{|f| f.set_with_filename(path)}
      end
    end
    
    # Sets the filename, content_type and data attributes from a local filename so that a File can be uploaded through the API
    def set_with_filename(path)
      return if path.blank?
      
      self.filename = ::File.basename(path)
      self.content_type = ::MIME::Types.type_for(path).first.content_type
      self.data = ::Base64.encode64(::File.read(path))
    end
    

  end
end