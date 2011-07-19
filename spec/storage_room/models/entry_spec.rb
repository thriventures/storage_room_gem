require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe StorageRoom::Entry do
  before(:each) do
    @string_field = StorageRoom::StringField.new(:name => 'Name', :identifier => 'name')
    @collection = StorageRoom::Collection.new(:name => 'Report', :fields => [@string_field])
    @collection.response_data[:@url] = '/collections/COLLECTION_ID'
    @collection.entry_class
  end
  
  context "Class" do
    context "Methods" do      
      describe "#show_path" do
        it "should be defined" do
          Report.show_path(1).should == '/collections/COLLECTION_ID/entries/1'
        end
      end
      
      describe "#index_path" do
        it "should be defined" do
          Report.index_path.should == '/collections/COLLECTION_ID/entries'
        end
      end
            
      describe "#search_path" do
        it "should be defined" do
          Report.search_path(:test =>1).should == '/collections/COLLECTION_ID/entries?test=1'
        end
      end
      
      describe "#json_name" do
        it "should be defined" do
          StorageRoom::Entry.json_name.should == 'entry'
          Report.json_name.should == 'entry'
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
      @entry = Report.new
    end
    
    describe "#collection" do
      it "should return collection" do
        @entry.collection.should == @collection
      end
    end
    
    describe "#id" do
      it "should return with url" do
        @entry.response_data[:@url] = 'http://api.storageroomapp.com/accounts/4d13574cba05613d25000004/collections/4d960916ba05617333000005/entries/4d96091aba05617333000014'
        @entry.id.should == '4d96091aba05617333000014'
      end
      
      it "should return nil" do
        @entry.id.should be_nil
      end
    end
    
    describe "#trashed?" do
      it "should return true" do
        @entry.response_data[:@trash] = true
        @entry.should be_trashed
      end
      
      it "should return false" do
        @entry.response_data[:@trash] = false
        @entry.should_not be_trashed
      end
    end
  end
end
