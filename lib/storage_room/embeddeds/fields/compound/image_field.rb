module StorageRoom
  
  class ImageField < CompoundField
    many :versions
  end
end