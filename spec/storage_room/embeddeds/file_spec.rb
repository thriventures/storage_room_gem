require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe StorageRoom::File do
  before(:each) do
    @file = StorageRoom::File.new
    @name = fixture_path('image.png')
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
      
      describe "#file_type" do
        it "should return type" do
          @file.response_data[:@url] = 'http://files.storageroomapp.com/accounts/4d13574cba05613d25000004/collection/4d960916ba05617333000005/entries/4d96091aba05617333000014/fields/k4d960916ba0561733300000f/file.png'
          @file.file_type.should == 'png'
        end
        
        it "should return nil" do
          @file.file_type.should be_nil
        end
      end
      
      describe "#local_filename" do
        it "should return filename" do
          @file.response_data[:@url] = 'http://files.storageroomapp.com/accounts/4d13574cba05613d25000004/collection/4d960916ba05617333000005/entries/4d96091aba05617333000014/fields/k4d960916ba0561733300000f/file.png'
          @file.local_filename.should == 'files.storageroomapp.com_accounts_4d13574cba05613d25000004_collection_4d960916ba05617333000005_entries_4d96091aba05617333000014_fields_k4d960916ba0561733300000f_file.png'
        end
        
        it "should return nil" do
          @file.local_filename.should be_nil
        end
        
      end
      
    end
  end
end
