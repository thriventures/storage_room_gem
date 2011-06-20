require File.dirname(__FILE__) + '/../lib/storage_room'

ACCOUNT_ID = '4dda7761b65245fde1000051' # your account id
APPLICATION_API_KEY = 'kCWTmS1wxYnxzJyteuIn' # your application's API key with read/write access

StorageRoom.authenticate(ACCOUNT_ID, APPLICATION_API_KEY)

StorageRoom.server = "api.lvh.me:3000"