require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module StorageRoom
  class TestAccessors
    include Accessors
    
    key :test
    key :test2
  end
end

describe StorageRoom::TestAccessors do
  
  context "Instance" do
    before(:each) do
      @test = StorageRoom::TestAccessors.new(:test => 1)
    end
    
    describe "#initialize" do    
      it "should set attributes" do
        @test.test.should == 1
        @test['test'].should be_nil
        @test.test2.should be_nil
        @test['test2'].should be_nil
      end
    end
    
    describe "#set_from_response_data" do  
      before(:each) do
        @test.set_from_response_data(:test2 => 3)
      end
        
      it "should reset attributes" do
        @test.test.should be_nil
      end
      
      it "should set new attributes" do
        @test['test2'].should == 3
        @test.test2.should == 3
      end
    end
    
    describe "#inspect" do
      it "should output string" do
        @test.inspect.should be_present
      end
    end
    
    describe "#[]" do
      it "should get attribute" do
        @test.set_from_response_data(:test2 => 3)
        
        @test[:test].should be_nil
        @test[:test2].should == 3
      end
    end
        
    describe "#attributes" do
      it "should return existing attributes" do
        @test.attributes[:test].should == 1
        @test.attributes['test'].should == 1
        @test.attributes['test2'].should be_nil
      end
    end
    
    describe "#attributes=" do
      before(:each) do
        @test.attributes = {:test => 0}
      end
      
      it "should set attributes" do
        @test.attributes[:test].should == 0
      end
    end
    
    describe "#as_json" do
      it "should return attributes as hash" do
        hash = @test.as_json
        hash.should be_an_instance_of(Hash)
        hash['test'].should == 1
      end
    end
    
    describe "#reset!" do
      it "should reset" do  
        @test.response_data = {'test' => 1}      
        @test.reset!
        @test.attributes.should == {}
        @test.response_data.should == {}
      end
    end
    
    describe "#loaded?" do
      it "should return true" do
        @test.response_data = {'test' => 1}
        @test.should be_loaded
      end
      
      it "should return false" do
        @test.reset!
        @test.should_not be_loaded
      end
    end

  end
  
end
