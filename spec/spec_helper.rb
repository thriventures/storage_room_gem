$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'storage_room'
# require 'spec'
# require 'spec/autorun'
require 'webmock/rspec'

RSpec.configure do |config|
  config.include WebMock::API
  
  config.before(:each) do
    StorageRoom.authenticate('USER_ID', 'APPLICATION_API_KEY')
    StorageRoom::IdentityMap.clear
  end
end


def stub_url(url)
  "APPLICATION_API_KEY:X@api.storageroomapp.com/accounts/USER_ID#{url}"
end

def fixture_file(name)
  path = File.expand_path("#{File.dirname(__FILE__)}/fixtures/#{name}")
  File.read(path)
end

def mock_httparty(code)
  httparty = mock('httparty')
  response = mock('response')
  response.stub(:code).and_return(code.to_s)
  
  httparty.stub(:response).and_return(response)
  
  httparty
end