require File.dirname(__FILE__) + '/../lib/storage_room'

ACCOUNT_ID = '4c8fd48542507175aa00002f' # your account id
APPLICATION_API_KEY = '43ruv6DDcNYlPZ5xH7en' # your application's API key with read/write access

StorageRoom.authenticate(ACCOUNT_ID, APPLICATION_API_KEY)