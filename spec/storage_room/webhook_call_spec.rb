require 'spec_helper'

class Announcement < StorageRoom::Entry
  key :text
  
  one :location
  one :shop
end

class Shop < StorageRoom::Entry
  key :name
end

describe StorageRoom::WebhookCall do
  before(:each) do
    @webhook_call = StorageRoom::WebhookCall.new
  end
  
  describe "#new_from_json_string" do
    it "should create object" do
      file = fixture_file('webhook_call.json')
      webhook_call = StorageRoom::Resource.new_from_json_string(file)
      
      webhook_call.should be_an_instance_of(StorageRoom::WebhookCall)        
      webhook_call[:@url].should_not be_present
      webhook_call[:@event].should == 'update'
      webhook_call.entry.should be_an_instance_of(Announcement)
      webhook_call.entry.text.should == 'WEBHOOK TEST'
      
      webhook_call.entry.location.should be_an_instance_of(StorageRoom::Location)
      webhook_call.entry.location.lat.should == 1.2
      webhook_call.entry.location.lng.should == 2.3

      stub_request(:get, "http://APPLICATION_API_KEY:X@api.storageroomapp.com/accounts/4e1e9c234250712eba000052/collections/4e1e9c234250712eba000063/entries/4e1f3259425071435e000099").
        to_return(:status => 200, :body => fixture_file('webhook_call_association.json'))
      
      shop = webhook_call.entry.shop
      shop.loaded?.should be_false
      shop.should be_an_instance_of(Shop)
      shop.loaded?.should be_true      
      shop['@url'].should == 'http://api.storageroomapp.com/accounts/4e1e9c234250712eba000052/collections/4e1e9c234250712eba000063/entries/4e1f3259425071435e000099'
      shop.name.should == 'SHOP'
    end
  end
end
