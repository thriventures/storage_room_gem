require 'spec_helper'

class Post < StorageRoom::Entry
  key :name
end

describe StorageRoom::Proxy do
  before(:each) do
    @hash_unloaded = {'@type' => 'Post', 'url' => 'URL'}
    @object_unloaded = Post.new
    
    @hash_loaded = {'@type' => 'Post', '@url' => 'URL', 'name' => 'NAME'}
    @object_loaded = Post.new_from_response_data(@hash_loaded)
    
    @proxy_unloaded = StorageRoom::Proxy.new(@object_unloaded)
    @proxy_loaded = StorageRoom::Proxy.new(@object_loaded)
  end
  
  context "Methods" do
    describe "#proxy" do
      it "should return true" do
        @proxy_unloaded.proxy?.should be_true
        @proxy_loaded.proxy?.should be_true
      end
    end
    
    describe "#response_data" do
      it "should return from object" do
        @proxy_unloaded.response_data.should == {}
        @proxy_loaded.response_data.should == @object_loaded.response_data
      end
    end
    
    describe "#loaded?" do
      it "should return false" do
        @proxy_unloaded.loaded?.should be_false
      end
      
      it "should return true" do
        @proxy_loaded.loaded?.should be_true
      end
    end
    
    describe "#method_missing" do
      it "should forward to object" do
        @proxy_loaded.name.should == 'NAME'
      end
      
      it "should reload if missing" do
        @object_unloaded.response_data = @hash_unloaded
        @object_unloaded.stub(:reload)
        @object_unloaded.should_receive(:reload).with(@hash_unloaded['url'], {})
        
        @proxy_unloaded.name
      end
    end
  end
end
