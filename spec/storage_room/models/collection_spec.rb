require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe StorageRoom::Collection do
  context "Class" do
    context "Methods" do
      describe "#show_path" do
        it "should be defined" do
          StorageRoom::Collection.show_path(1).should == '/collections/1'
        end
      end
      
      describe "#index_path" do
        it "should be defined" do
          StorageRoom::Collection.index_path.should == '/collections'
        end
      end
      
      describe "#resources_path" do
        it "should be defined" do
          StorageRoom::Collection.resources_path(1).should == '/collections/1/resources'
        end
      end
      
      describe "#json_name" do
        it "should be defined" do
          StorageRoom::Collection.json_name.should == 'collection'
        end
      end
    end
    
  end
  
  context "Instance" do
    before(:each) do
      @collection = StorageRoom::Collection.new
    end
    
    describe "#resources" do
      it "should load" do
        StorageRoom::Array.should_receive(:load)
        @collection.resources
      end
    end
    
    describe "#resource_class" do
      it "should return class" do
        @collection[:identifier] = 'guidebook'
        klass = @collection.resource_class
        klass.should == Guidebook
      end
    end
    
  end
end
