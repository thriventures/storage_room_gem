require 'spec_helper'

describe StorageRoom::AtomicField do
  before(:each) do
    @field = StorageRoom::AtomicField.new(:identifier => 'identifier')
  end
  
  context "Configuration" do
    it "should have keys" do
      keys = StorageRoom::AtomicField.attribute_options_including_superclasses.keys
      
      [:default_value, :choices, :include_blank_choice].each do |key|
        keys.should include(key)
      end
    end
  end

  context "Methods" do
    describe "#add_to_entry_class" do
      it "should add key" do
        klass = StorageRoom::Entry
        klass.should_receive(:key).with('identifier')
        @field.add_to_entry_class(klass)
      end
    end
  end
end