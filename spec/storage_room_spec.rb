require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe StorageRoom do
  describe "#authenticate" do
    before(:each) do
      StorageRoom.authenticate('account_id', 'api_key')
    end
    
    it "should set basic auth" do
      StorageRoom::Base.default_options[:basic_auth].should == {:username => 'api_key', :password => 'X'}
    end
    
    it "should set variables" do
      StorageRoom.account_id == 'account_id'
      StorageRoom.api_key == 'api_key'
    end
    
    it "should update uri" do
      StorageRoom::Base.base_uri.should include('account_id')
    end
  end
  
  describe "#user_agent" do
    before(:each) do
      StorageRoom.user_agent = 'agent'
    end
    
    it "should set user agent" do
      StorageRoom::Base.headers['User-Agent'].should == 'agent'
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
      StorageRoom::Base.base_uri.should include('server')
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
      StorageRoom::Base.base_uri.should include('https://')
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
      StorageRoom::Base.default_options[:http_proxyaddr].should == 'http_proxy'
      StorageRoom::Base.default_options[:http_proxyport].should == 123      
    end
    
    it "should set variables" do
      StorageRoom.proxy_server.should == 'http_proxy'
      StorageRoom.proxy_port.should == 123
    end
  end
  
  describe "#class_for_name" do
    it "should get class" do
      klass = StorageRoom.class_for_name('Recipe')
      klass.should be_an_instance_of(Class)
      klass.name.should == 'Recipe'
    end
    
    it "should get StorageRoom class" do
      klass = StorageRoom.class_for_name('Resource')
      klass.should be_an_instance_of(Class)
      klass.should == StorageRoom::Resource
    end
  end
end
