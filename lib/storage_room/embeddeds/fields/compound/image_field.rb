module StorageRoom
  
  class ImageField < AttachmentField
    many :versions
  end
end