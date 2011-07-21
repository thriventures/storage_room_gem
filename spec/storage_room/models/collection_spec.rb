require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe StorageRoom::Collection do
  before(:each) do
    @field = StorageRoom::StringField.new(:name => 'Name', :identifier => 'name')
    @collection = StorageRoom::Collection.new(:name => 'Restaurant', :fields => [@field])
    @collection.response_data[:@version] = 1
    @collection.response_data[:@url] = "URL"
    
    @collection2 = StorageRoom::Collection.new
  end
  
  context "Class" do
    context "Methods" do
      describe "#show_path" do
        it "should be defined" do
          StorageRoom::Collection.show_path(1).should == "#{StorageRoom::Resource.base_uri}/collections/1"
        end
      end
      
      describe "#index_path" do
        it "should be defined" do
          StorageRoom::Collection.index_path.should == "#{StorageRoom::Resource.base_uri}/collections"
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
    describe "#entries" do
      it "should load" do
        StorageRoom::Array.should_receive(:load)
        @collection.entries
      end
      
      it "should have an error if not loaded" do
        lambda { @collection2.entries }.should raise_error(StorageRoom::ResourceNotLoadedError)
      end
    end
    
    describe "#deleted_entries" do
      it "should load" do
        StorageRoom::Array.should_receive(:load)
        @collection.deleted_entries
      end
      
    end
    
    describe "#entry_class_name" do
      it "should return string" do
        @collection.entry_class_name.should == 'Restaurant'
      end
      
      it "should have an error if not loaded" do
        lambda { @collection2.entry_class_name }.should raise_error(StorageRoom::ResourceNotLoadedError)
      end
    end
    
    describe "#entry_class" do
      it "should return class" do
        @collection.entry_class.should == Restaurant
      end
      
      it "should have an error if not loaded" do
        lambda { @collection2.entry_class }.should raise_error(StorageRoom::ResourceNotLoadedError)
      end
    end
    
    describe "#field" do
      it "should return existing field" do
        @collection.field('name').should == @field
      end
      
      it "should return nil for non-existant field" do
        @collection.field('undefined').should be_nil
      end

      it "should have an error if not loaded" do
        lambda { @collection2.field('name') }.should raise_error(StorageRoom::ResourceNotLoadedError)
      end
    end
  end
  
  context "Private Methods" do
    describe "#initialize_entry_class" do
      it "should create class" do
        klass = @collection.entry_class
        klass.collection.should == @collection
        
        guidebook = klass.new(:name => 'NAME')
        guidebook.name.should == 'NAME'
      end
      
    end
    
    
  end
end
