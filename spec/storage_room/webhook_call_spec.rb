require 'spec_helper'

class Announcement < StorageRoom::Entry
  key :text
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
    end
  end
end
