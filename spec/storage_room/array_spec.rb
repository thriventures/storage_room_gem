require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

class PointOfInterest < StorageRoom::Model
  key :value
end

describe StorageRoom::Array do
  context "Class" do
    context "Configuration" do
  
    end
    
    context "Methods" do
      
    end
  end
  
  context "Instance" do
    before(:each) do
      @array = StorageRoom::Array.new
    end
    
    describe "#initialize" do
      it "should set resources" do
        @array.resources.should == []
      end
    end
    
    describe "#set_from_response_data" do
      before(:each) do
        @hash = {'@page' => 1, 'resources' => [{'value' => 1, '@type' => 'PointOfInterest'}, {'value' => 2, '@type' => 'PointOfInterest'}]}
        @array.set_from_response_data(@hash)
      end
      
      it "should set meta data" do
        @array['@page'].should == 1
      end
      
      it "should set resources" do
        @array.resources.should have(2).items
        @array.resources[0].should be_an_instance_of(PointOfInterest)
        @array.resources[0].value.should == 1
        @array.resources[1].should be_an_instance_of(PointOfInterest)        
        @array.resources[1].value.should == 2
      end
    end
    
    describe "#reset!" do
      it "should reset" do
        @array.reset!
        @array.resources.should == []
      end
    end
    
    describe "#load_next_page!" do
      it "should not load when not present" do
        @array.load_next_page!.should be_false
      end
      
      it "should load when present" do
        @array.response_data[:@next_page_url] = "url"
        @array.stub(:reload)
        @array.should_receive(:reload)
        @array.load_next_page!.should be_true
      end
    end
    
    describe "#load_previous_page!" do
      it "should not load when not present" do
        @array.load_previous_page!.should be_false
      end
      
      it "should load when present" do
        @array.response_data[:@previous_page_url] = "url"
        @array.stub(:reload)
        @array.should_receive(:reload)
        @array.load_previous_page!.should be_true
      end
    end
  end
end
