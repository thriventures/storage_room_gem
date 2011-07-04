require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe StorageRoom::File do
  before(:each) do
    @file = StorageRoom::File.new
    @name = ::File.expand_path(File.dirname(__FILE__) + '/../../fixtures/image.png')
  end
  
  context "Class Methods" do
    describe "#new_with_filename" do
      it "return a new file object" do
        file = StorageRoom::File.new_with_filename(@name)
        file.should be_an_instance_of(StorageRoom::File)
        file.content_type.should == 'image/png'
        file.filename.should == 'image.png'
        file.data.should == ::Base64.encode64(::File.read(@name))
      end
    end
  end
  
  context "Methods" do
    describe "#set_with_filename" do
      it "should set with filename" do
        @file.set_with_filename(@name)
        
        @file.content_type.should == 'image/png'
        @file.filename.should == 'image.png'
        @file.data.should == ::Base64.encode64(::File.read(@name))
      end
      
      describe "#as_json" do
        it "should return hash" do
          @file.set_with_filename(@name)
          
          hash = @file.as_json.with_indifferent_access
          hash[:content_type].should == @file.content_type
          hash[:filename].should == @file.filename
          hash[:data].should == @file.data
        end
      end
      
    end
  end
end
