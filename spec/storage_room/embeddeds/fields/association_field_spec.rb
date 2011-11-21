require 'spec_helper'

describe StorageRoom::AssociationField do
  before(:each) do
    @field = StorageRoom::AssociationField.new(:collection_url => 'URL')
  end
  
  context "Configuration" do
    it "should have keys" do
      keys = StorageRoom::AssociationField.attribute_options_including_superclasses.keys
      
      [:collection_url].each do |key|
        keys.should include(key)
      end
    end
  end
  
  context "Methods" do
    describe "#collection" do
      it "should return collection" do
        collection = StorageRoom::Collection.new
        StorageRoom::Collection.stub(:load).and_return(collection)
        StorageRoom::Collection.should_receive(:load).with('URL')
        
        @field.collection.should == collection
      end
    end
  end
end
