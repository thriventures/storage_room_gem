require File.join(File.dirname(__FILE__), '..', 'lib', 'storage_room')

ACCOUNT_ID = '4d13574cba05613d25000004' # your account id
APPLICATION_API_KEY = 'DZHpRbsJ7VgFXhybKWmT' # your application's API key with read/write access

StorageRoom.authenticate(ACCOUNT_ID, APPLICATION_API_KEY)

# Optionally set the server to a custom domain
# StorageRoom.server = "api.lvh.me:3000"
StorageRoom.server = "api.storageroomapp.com"