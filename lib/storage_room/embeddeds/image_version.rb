module StorageRoom
  # Part of an ImageField
  class ImageVersion < Embedded
    key :identifier
    key :format
    key :resize_mode
    key :width
    key :height
    key :scale
    
  end
end