require 'spec_helper'

describe StorageRoom::OneAssociationField do
  before(:each) do
    @field = StorageRoom::OneAssociationField.new(:collection_url => 'URL', :identifier => 'identifier')
  end
  
  context "Methods" do
    describe "#add_to_entry_class" do
      it "should add one" do
        StorageRoom::Collection.stub(:load)
        
        klass = StorageRoom::Entry
        klass.should_receive(:one).with('identifier')
        @field.add_to_entry_class(klass)
      end
    end
  end
end
