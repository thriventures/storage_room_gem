require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StorageRoom::Base do
  context "Class" do
    context "Configuration" do
      describe "Headers" do
        it "should have User-Agent" do
          StorageRoom::Base.headers['User-Agent'].should be_present
        end
      
        it "should set Content Type" do
          StorageRoom::Base.headers['Content-Type'].should == 'application/json'
        end
      
        it "should set Accept" do
          StorageRoom::Base.headers['Accept'].should == 'application/json'
        end
      end
      
      it "should not have base_uri" do
        StorageRoom::Base.base_uri.should be_present
      end
      
      it "should have format" do
        StorageRoom::Base.default_options[:format].should == :json
      end
    end
    
    context "Methods" do      
      describe "#load" do
        it "should load" do
          stub_request(:get, stub_url('/collections')).to_return(:body => fixture_file('collections.json'), :status => 200)
          
          array = StorageRoom::Array.load('/collections')          
          array[:@type].should == 'Array'
        end
        
        it "should raise on error" do
          stub_request(:get, stub_url('/collections')).to_return(:status => 500)
          
          lambda {
            StorageRoom::Array.load('/collections')
          }.should raise_error(StorageRoom::RequestFailed)
          
        end
      end
            
      describe "#handle_critical_response_errors" do
        it "should handle no error" do
          httparty = mock_httparty(200)
          StorageRoom::Base.handle_critical_response_errors(httparty).should be_true
        end
        
        it "should raise error" do
          lambda {
            StorageRoom::Base.handle_critical_response_errors(mock_httparty(500))
          }.should raise_error(StorageRoom::RequestFailed)
        end
      end
      
      describe "#create_from_api" do
        it "should create array" do
          hash = {'@type' => 'Array', 'resources' => []}
          result = StorageRoom::Base.create_from_api(hash)
          result.should be_an_instance_of(StorageRoom::Array)
          result[:@type].should == 'Array'
        end
        
        it "should create collection" do
          hash = {'@type' => 'Collection', 'name' => 'Guidebook'}
          result = StorageRoom::Base.create_from_api(hash)
          result.should be_an_instance_of(StorageRoom::Collection)
          result[:name].should == 'Guidebook'
        end
        
        it "should create entry" do
          hash = {'@type' => 'Guidebook', 'title' => 'Something'}
          result = StorageRoom::Base.create_from_api(hash)
          result.should be_an_instance_of(Guidebook)
          result[:title].should == 'Something'
        end
      end
      
      describe "#meta_data?" do
        it "should detect" do
          StorageRoom::Base.meta_data?('@test').should be_true
          StorageRoom::Base.meta_data?('test').should be_false
        end
      end
      
    end
  end
  
  context "Instance" do
    before(:each) do
      @base = StorageRoom::Base.new(:test => 1, :@attr => 2)
    end
           
    describe "#url" do
      it "should return url" do
        @base.url.should be_nil
        @base[:@url] = 'url'
        @base.url.should == 'url'
      end
    end
    
    describe "#version" do
      it "should return version" do
        @base.version.should be_nil
        @base[:@version] = 1
        @base.version.should == 1
      end
    end
    

  end
  
end
