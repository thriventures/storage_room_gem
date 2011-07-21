require 'spec_helper'

describe StorageRoom::DeletedEntry do

  
  context "Instance" do
    before(:each) do
      @hash = {
        '@type' => 'DeletedEntry',
        '@url'  => "http://api.storageroomapp.com/accounts/4e1e9c234250712eba000052/deleted_entries/4e269c0f42507106fc000001",
        '@account_url'  => "http://api.storageroomapp.com/accounts/4e1e9c234250712eba000052",
        '@collection_url'  => "http://api.storageroomapp.com/accounts/4e1e9c234250712eba000052/collections/4e1e9c234250712eba000056",
        '@entry_url'  => "http://api.storageroomapp.com/accounts/4e1e9c234250712eba000052/collections/4e1e9c234250712eba000056/entries/4e269c2742507106fc000004",
        '@deleted_at' => "2011-07-20T09:13:13Z"
      }
      @deleted_entry = StorageRoom::Resource.new_from_response_data(@hash)
    end
    
    describe "#entry_url" do
      it "should return url" do
        @deleted_entry.entry_url.should == @hash['@entry_url']
      end
    end
    
    describe "#entry_id" do
      it "should return id" do
        @deleted_entry.entry_id.should == '4e269c2742507106fc000004'
      end
    end
    
    describe "#collection_url" do
      it "should return url" do
        @deleted_entry.collection_url.should == @hash['@collection_url']
      end
    end
    
    describe "#deleted_at" do
      it "should return date" do
        @deleted_entry.deleted_at.should be_present
      end
    end 
    
  end
end
