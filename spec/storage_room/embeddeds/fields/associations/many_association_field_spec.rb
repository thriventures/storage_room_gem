require 'spec_helper'

describe StorageRoom::ManyAssociationField do
  describe StorageRoom::OneAssociationField do
    before(:each) do
      @field = StorageRoom::ManyAssociationField.new(:collection_url => 'URL', :identifier => 'identifier')
    end

    context "Methods" do
      describe "#add_to_entry_class" do
        it "should add many" do
          StorageRoom::Collection.stub(:load)

          klass = StorageRoom::Entry
          klass.should_receive(:many).with('identifier')
          @field.add_to_entry_class(klass)
        end
      end
    end
  end
end
