require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

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
      it "should set items" do
        @array.items.should == []
      end
    end
    
    describe "#set_from_api" do
      before(:each) do
        @hash = {'@page' => 1, 'items' => [{'one' => 1, '@type' => 'Guidebook'}, {'two' => 2, '@type' => 'Guidebook'}]}
        @array.set_from_api(@hash)
      end
      
      it "should set meta data" do
        @array['@page'].should == 1
      end
      
      it "should set items" do
        @array.items.should have(2).items
        @array.items[0].should be_an_instance_of(Guidebook)
        @array.items[0][:one].should == 1
        @array.items[1].should be_an_instance_of(Guidebook)        
        @array.items[1][:two].should == 2
      end
    end
    
    describe "#reset!" do
      it "should reset" do
        @array.reset!
        @array.items.should == []
      end
    end
    
    describe "#load_next_page!" do
      it "should not load when not present" do
        @array.load_next_page!.should be_false
      end
      
      it "should load when present" do
        @array[:@next_page] = "url"
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
        @array[:@previous_page] = "url"
        @array.stub(:reload)
        @array.should_receive(:reload)
        @array.load_previous_page!.should be_true
      end
    end
  end
end
