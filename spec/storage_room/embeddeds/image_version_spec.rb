require 'spec_helper'

describe StorageRoom::ImageVersion do
  before(:each) do
    @image_version = StorageRoom::ImageVersion.new(:identifier => 'thumb', :format => 'png', :resize_mode => 'fit', :width => 100, :height => 200)
  end
  
  context "Configuration" do
    describe "#keys" do
      it "should have keys" do        
        @image_version.identifier.should == 'thumb'
        @image_version.format.should == 'png'
        @image_version.resize_mode.should == 'fit'
        @image_version.width.should == 100
        @image_version.height.should == 200
      end
    end
  end
end
