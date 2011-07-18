require 'spec_helper'

describe StorageRoom::WebhookDefinition do

  before(:each) do
    @webhook_definition = StorageRoom::WebhookDefinition.new(:url => 'URL', :on_create => true, :on_update => true, :on_delete => true, :api => true, :web_interface => true, :username => 'username', :password => 'password')
  end

  context "Configuration" do
    describe "#keys" do
      it "should have keys" do        
        @webhook_definition.url.should == 'URL'
        
        @webhook_definition.on_create.should be_true
        @webhook_definition.on_update.should be_true
        @webhook_definition.on_delete.should be_true
        
        @webhook_definition.api.should be_true
        @webhook_definition.web_interface.should be_true
        
        @webhook_definition.username.should == 'username'
        @webhook_definition.password.should == 'password'
      end
    end
  end
  
end
