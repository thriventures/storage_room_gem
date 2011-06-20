require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StorageRoom::Embedded do
  context "Configuration" do
    it "should include Accessors" do
      StorageRoom::Embedded.should include(StorageRoom::Accessors)
    end
  end
end
