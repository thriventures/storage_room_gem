require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe StorageRoom::Entry do
  context "Class" do
    context "Methods" do
      before(:each) do
        StorageRoom.class_for_name('Guidebook')
      end
      
      describe "#show_path" do
        it "should be defined" do
          Guidebook.show_path(1).should == '/collections/guidebooks/entries/1'
        end
      end
      
      describe "#index_path" do
        it "should be defined" do
          Guidebook.index_path.should == '/collections/guidebooks/entries'
        end
      end
      
      describe "#collection_path" do
        it "should be defined" do
          Guidebook.collection_path.should == '/collections/guidebooks'
        end
      end
      
      describe "#search_path" do
        it "should be defined" do
          Guidebook.search_path(:test =>1).should == '/collections/guidebooks/entries?test=1'
        end
      end
      
      describe "#json_name" do
        it "should be defined" do
          StorageRoom::Entry.json_name.should == 'entry'
          Guidebook.json_name.should == 'entry'
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
      @entry = StorageRoom::Entry.new
    end
    
    describe "#collection" do
      it "should load" do
        StorageRoom::Collection.should_receive(:load)
        @entry.collection
      end
    end
  end
end
