require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe StorageRoom::Resource do
  context "Class" do
    context "Methods" do
      before(:each) do
        StorageRoom.class_for_name('Guidebook')
      end
      
      describe "#show_path" do
        it "should be defined" do
          Guidebook.show_path(1).should == '/collections/guidebooks/resources/1'
        end
      end
      
      describe "#index_path" do
        it "should be defined" do
          Guidebook.index_path.should == '/collections/guidebooks/resources'
        end
      end
      
      describe "#collection_path" do
        it "should be defined" do
          Guidebook.collection_path.should == '/collections/guidebooks'
        end
      end
      
      describe "#search_path" do
        it "should be defined" do
          Guidebook.search_path(:test =>1).should == '/collections/guidebooks/resources?test=1'
        end
      end
      
      describe "#json_name" do
        it "should be defined" do
          StorageRoom::Resource.json_name.should == 'resource'
          Guidebook.json_name.should == 'resource'
        end
      end
      
      describe "#collection_id" do
        it "should be defined" do
          Guidebook.collection_id.should == 'guidebooks'
        end
      end
      
      describe "#search" do
        it "should load" do
          pending
        end
      end
    end
    
  end
  
  context "Instance" do
    before(:each) do
      @resource = StorageRoom::Resource.new
    end
    
    describe "#collection" do
      it "should load" do
        StorageRoom::Collection.should_receive(:load)
        @resource.collection
      end
    end
  end
end
