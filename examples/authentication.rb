require File.join(File.dirname(__FILE__), '..', 'lib', 'storage_room')

ACCOUNT_ID = '4e1e9c234250712eba000052' # your account id
APPLICATION_API_KEY = 'fgK8Di4FYuRKtk2Xd12A' # your application's API key with read/write access

StorageRoom.authenticate(ACCOUNT_ID, APPLICATION_API_KEY)

StorageRoom.server = "api.lvh.me:3000"
# StorageRoom.server = "api.storageroomapp.com"