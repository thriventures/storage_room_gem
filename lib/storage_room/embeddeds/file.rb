require 'open-uri'


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
    
    # Returns the file type based on the extension
    def file_type
      self[:@url] ? ::File.extname(self[:@url])[1..-1] : nil
    end
    
    # Download the file to the local disk
    def download_to_directory(path)
      Dir.mkdir(path) unless ::File.directory?(path)
      download_file(self[:@url], ::File.join(path, local_filename))
      true
    end
    
    # The localized filename built out of the URL
    def local_filename
      self[:@url] ? localize_filename(self[:@url]) : nil
    end
    
    protected
      def localize_filename(filename)
        filename.gsub(/\Ahttps?:\/\//, '').gsub('/', '_')
      end
    
      def download_file(url, path)
        file = open(path, "wb")
        file.write(open(url).read)
        file.close
      end
    

  end
end