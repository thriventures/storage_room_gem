require 'spec_helper'

describe StorageRoom::Field do
  before(:each) do
    @field = StorageRoom::Field.new
  end
  
  context "Configuration" do
    it "should have keys" do
      keys = StorageRoom::Field.attribute_options.keys
      
      [:name, :identifier, :interface, :hint, :input_type, :required, :unique, :maximum_length, :minimum_length, :minimum_number, :maximum_number, :minimum_size, :maximum_size].each do |key|
        keys.should include(key)
      end
    end
  end
  
  context "Methods" do
    describe "#add_to_entry_class" do
      it "should have method" do
        @field.add_to_entry_class(StorageRoom::Entry)
      end
    end
  end
end
