require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe StorageRoom::Location do
  before(:each) do
    @location = StorageRoom::Location.new(:lat => 1, :lng => 2)
  end
  
  context "Configuration" do
    it "should have keys" do
      keys = StorageRoom::Location.attribute_options_including_superclasses.keys
      
      [:lat, :lng].each do |key|
        keys.should include(key)
      end
    end
  end
end
