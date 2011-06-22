require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StorageRoom::Resource do
  context "Class" do
    context "Configuration" do
      describe "Headers" do
        it "should have User-Agent" do
          StorageRoom::Resource.headers['User-Agent'].should be_present
        end
      
        it "should set Content Type" do
          StorageRoom::Resource.headers['Content-Type'].should == 'application/json'
        end
      
        it "should set Accept" do
          StorageRoom::Resource.headers['Accept'].should == 'application/json'
        end
      end
      
      it "should not have base_uri" do
        StorageRoom::Resource.base_uri.should be_present
      end
      
      it "should have format" do
        StorageRoom::Resource.default_options[:format].should == :json
      end
      
      it "should include Accessors" do
        StorageRoom::Embedded.should include(StorageRoom::Accessors)
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
          }.should raise_error(StorageRoom::RequestFailedError)
          
        end
      end
      
      describe "#loaded?" do
        before(:each) do
          @resource = StorageRoom::Resource.new
        end
        
        it "should return true" do
          @resource.response_data['@url'] = 'URL'
          @resource.should be_loaded
        end
        
        it "should return false" do
          @resource.should_not be_loaded
        end
      end
            
      describe "#handle_critical_response_errors" do
        it "should handle no error" do
          httparty = mock_httparty(200)
          StorageRoom::Resource.handle_critical_response_errors(httparty).should be_true
        end
        
        it "should raise error" do
          lambda {
            StorageRoom::Resource.handle_critical_response_errors(mock_httparty(500))
          }.should raise_error(StorageRoom::RequestFailedError)
        end
      end
            
      describe "#meta_data?" do
        it "should detect" do
          StorageRoom::Resource.meta_data?('@test').should be_true
          StorageRoom::Resource.meta_data?('test').should be_false
        end
      end
      
    end
  end
  
  context "Instance" do
    before(:each) do
      @base = StorageRoom::Resource.new(:test => 1, :@attr => 2)
    end
               

  end
  
end
