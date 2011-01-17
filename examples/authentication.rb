require File.dirname(__FILE__) + '/../lib/storage_room'

ACCOUNT_ID = '4cef9a8c425071fa6900002f' # your account id
APPLICATION_API_KEY = 'c499kx9L6aBfvJlvSKbF' # your application's API key with read/write access

StorageRoom.authenticate(ACCOUNT_ID, APPLICATION_API_KEY)