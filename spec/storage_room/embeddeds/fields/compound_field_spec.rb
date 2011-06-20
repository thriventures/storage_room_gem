require 'spec_helper'

describe StorageRoom::CompoundField do
  before(:each) do
    @field = StorageRoom::CompoundField.new(:identifier => 'identifier')
  end
  
  context "Methods" do
    describe "#add_to_entry_class" do
      it "should add one" do        
        klass = StorageRoom::Entry
        klass.should_receive(:one).with('identifier')
        @field.add_to_entry_class(klass)
      end
    end
  end
end
