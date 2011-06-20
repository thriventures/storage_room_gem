require 'storage_room'

StorageRoom.debug = true

# Optionally have an init file in your home directory
file = File.expand_path('~/.storage_room_gem.rb')

begin
  require file
rescue LoadError
  StorageRoom.log("Could not load init file: #{file}")
end