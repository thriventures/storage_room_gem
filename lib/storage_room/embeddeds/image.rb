module StorageRoom
  # An Image with optional thumbnails
  class Image < File     
    # Returns all valid ImageVersion identifiers for this Image
    def version_identifiers
      self[:@versions].keys
    end
    
    # Returns the URL of an Image or the URL of a version if a string or symbol is passed
    def url(name = nil)
      if name
        if version_identifiers.include?(name.to_s)
          self[:@versions][name.to_s][:@url]
        else
          raise "Invalid Image Version identifier: '#{name}' (must be #{version_identifiers.join(', ')})"
        end
      else
        self[:@url]
      end
    end
    
    # Are versions of the Image still being processed on the server?
    def processing?
      self[:@processing]
    end
    
    def local_filename(name = nil)
      localize_filename(url(name))
    end
    
    def download_to_directory(path)
      super
      
      version_identifiers.each do |version|
        download_file(self.url(version), ::File.join(path, local_filename(version)))
      end
      true
    end
    
  end
end