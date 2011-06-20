require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class Client < StorageRoom::Entry
  key :name
end

describe StorageRoom do
  describe "#authenticate" do
    before(:each) do
      StorageRoom.authenticate('account_id', 'api_key')
    end
    
    it "should set basic auth" do
      StorageRoom::Resource.default_options[:basic_auth].should == {:username => 'api_key', :password => 'X'}
    end
    
    it "should set variables" do
      StorageRoom.account_id == 'account_id'
      StorageRoom.api_key == 'api_key'
    end
    
    it "should update uri" do
      StorageRoom::Resource.base_uri.should include('account_id')
    end
  end
  
  describe "#user_agent" do
    before(:each) do
      StorageRoom.user_agent = 'agent'
    end
    
    it "should set user agent" do
      StorageRoom::Resource.headers['User-Agent'].should == 'agent'
    end
    
    it "should set variables" do
      StorageRoom.user_agent.should == 'agent'
    end
  end
  
  describe "#server" do
    before(:each) do
      StorageRoom.server = 'server'
    end
    
    it "should update uri" do
      StorageRoom::Resource.base_uri.should include('server')
    end
    
    it "should set variables" do
      StorageRoom.server.should == 'server'
    end
    
    it "should return default" do
      StorageRoom.server = nil
      StorageRoom.server.should be_present
    end
  end
  
  describe "#ssl" do
    before(:each) do
      StorageRoom.ssl = true
    end
    
    it "should update uri" do
      StorageRoom::Resource.base_uri.should include('https://')
    end
    
    it "should set variables" do
      StorageRoom.ssl.should be_true
    end
  end
  
  describe "#http_proxy" do
    before(:each) do
      StorageRoom.http_proxy('http_proxy', 123)
    end
    
    it "should set proxy" do
      StorageRoom::Resource.default_options[:http_proxyaddr].should == 'http_proxy'
      StorageRoom::Resource.default_options[:http_proxyport].should == 123      
    end
    
    it "should set variables" do
      StorageRoom.proxy_server.should == 'http_proxy'
      StorageRoom.proxy_port.should == 123
    end
  end
  
  describe "#entry_class_mappings" do
    it "should return hash" do
      StorageRoom.entry_class_mappings.should == {}
    end
  end
  
  describe "#add_entry_class_mapping" do
    it "should add to hash" do
      StorageRoom.add_entry_class_mapping('Recipes List', 'List')
      StorageRoom.entry_class_mappings.should include('Recipes List' => 'List')
    end
  end
  
  describe "#entry_class_for_name" do
    it "should return with mapping" do
      StorageRoom.add_entry_class_mapping('Recipes List', 'List')
      StorageRoom.entry_class_for_name('Recipes List').should == 'List'
    end
    
    it "should return without mapping" do
      StorageRoom.entry_class_for_name('Restaurant Visits').should == 'RestaurantVisit'      
    end
  end
  
  describe "#class_for_name" do
    it "should get class" do
      klass = StorageRoom.class_for_name('Client')
      klass.should be_an_instance_of(Class)
      klass.name.should == 'Client'
    end
    
    it "should get StorageRoom class" do
      klass = StorageRoom.class_for_name('Entry')
      klass.should be_an_instance_of(Class)
      klass.should == StorageRoom::Entry
    end
    
    it "should raise an error for unknown classes" do
      lambda {
        StorageRoom.class_for_name("Unknown")
      }.should raise_error(StorageRoom::ClassNotFound)
      
    end
  end
  
end
