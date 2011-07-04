require 'spec_helper'

describe StorageRoom::Image do
  before(:each) do
    @image = StorageRoom::Image.new
    @image.response_data = {
      '@type' => 'Image',
      '@url' => 'URL',
      '@processing' => false,
      '@versions' => {
        'thumbnail' => {
          '@url' => 'THUMBNAIL_URL'
        }
      }
    }
  end
  
  context "Methods" do
    describe "#image_versions" do
      it "should return array" do
        @image.version_identifiers.should == ['thumbnail']
      end
    end
    
    describe "#url" do
      it "should return URL for the image" do
        @image.url.should == 'URL'
      end
      
      it "should return URL for a version" do
        @image.url(:thumbnail).should == 'THUMBNAIL_URL'
      end
      
      it "should raise error on invalid version" do
        lambda {
          @image.url(:asdf)
        }.should raise_error
      end
    end
    
    describe "#processing?" do
      it "should return true" do
        @image.response_data['@processing'] = true
        @image.should be_processing
      end
      
      it "should return false" do
        @image.response_data['@processing'] = false
        @image.should_not be_processing
      end
    end
    
  end
end
