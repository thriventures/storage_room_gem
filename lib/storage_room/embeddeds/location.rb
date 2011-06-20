module StorageRoom
  # A location with coordinates that is embedded in a entry
  class Location < Embedded
    key :lat
    key :lng
  end
end