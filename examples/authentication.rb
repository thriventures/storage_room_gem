require File.dirname(__FILE__) + '/../lib/storage_room'

# ACCOUNT_ID = '4cef9a8c425071fa6900002f' # your account id
# APPLICATION_API_KEY = 'c499kx9L6aBfvJlvSKbF' # your application's API key with read/write access

ACCOUNT_ID = '4d13574cba05613d25000004'
APPLICATION_API_KEY = 'Tg_2oR2aBc83_BJa4k0Y'

# StorageRoom.server = 'api.lvh.me:3000'
StorageRoom.http_proxy('localhost', '8888')
StorageRoom.authenticate(ACCOUNT_ID, APPLICATION_API_KEY)