require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

module StorageRoom
  class TestAccessors
    include Accessors
    
    key :test
    key :test2
  end
  
  class TestAccessors2 < TestAccessors
    key :test3
  end
  
  class TestAccessors3 < TestAccessors
    key :test4
    key :test5
  end
  
  class TestAccessors4 < TestAccessors3
    key :test6
  end
end

describe StorageRoom::TestAccessors do
  context "Class" do
    describe "#new_from_json_file" do
      it "should open file" do
        path = fixture_path('export_collection.json')
        object = StorageRoom::Resource.new_from_json_file(path)
        object.should be_an_instance_of(StorageRoom::Collection)
      end
    end
    
    describe "#response_data_is_association?" do
      it "should return true" do
        hash = {'@type' => 'Tour', 'url' => 'URL'}
        StorageRoom::Resource.response_data_is_association?(hash).should be_true
      end
      
      it "should return false for too many keys" do
        hash = {'@type' => 'Tour', 'url' => 'URL', 'more' => 3}
        StorageRoom::Resource.response_data_is_association?(hash).should be_false
      end
      
      it "should return false for wrong keys" do
        hash = {'@type' => 'Tour', 'more' => 3}
        StorageRoom::Resource.response_data_is_association?(hash).should be_false
      end
    end
    
    describe "Inheritance" do
      it "should have correct attribute_options hash" do
        StorageRoom::TestAccessors.attribute_options.should have(2).items
        StorageRoom::TestAccessors.attribute_options[:test].should be_present
        StorageRoom::TestAccessors.attribute_options[:test2].should be_present
        
        StorageRoom::TestAccessors.attribute_options_including_superclasses.should have(2).items
        StorageRoom::TestAccessors.attribute_options_including_superclasses[:test].should be_present
        StorageRoom::TestAccessors.attribute_options_including_superclasses[:test2].should be_present

        #
        StorageRoom::TestAccessors2.attribute_options.should have(1).item
        StorageRoom::TestAccessors2.attribute_options[:test3].should be_present

        StorageRoom::TestAccessors2.attribute_options_including_superclasses.should have(3).items
        StorageRoom::TestAccessors2.attribute_options_including_superclasses[:test].should be_present
        StorageRoom::TestAccessors2.attribute_options_including_superclasses[:test2].should be_present
        StorageRoom::TestAccessors2.attribute_options_including_superclasses[:test3].should be_present
        
        #
        StorageRoom::TestAccessors3.attribute_options.should have(2).item
        StorageRoom::TestAccessors3.attribute_options[:test4].should be_present
        StorageRoom::TestAccessors3.attribute_options[:test5].should be_present
        
        StorageRoom::TestAccessors3.attribute_options_including_superclasses.should have(4).items
        StorageRoom::TestAccessors3.attribute_options_including_superclasses[:test].should be_present
        StorageRoom::TestAccessors3.attribute_options_including_superclasses[:test2].should be_present
        StorageRoom::TestAccessors3.attribute_options_including_superclasses[:test4].should be_present
        StorageRoom::TestAccessors3.attribute_options_including_superclasses[:test5].should be_present
        
        #
        StorageRoom::TestAccessors4.attribute_options.should have(1).item
        StorageRoom::TestAccessors4.attribute_options[:test6].should be_present
        
        StorageRoom::TestAccessors4.attribute_options_including_superclasses.should have(5).items
        StorageRoom::TestAccessors4.attribute_options_including_superclasses[:test].should be_present
        StorageRoom::TestAccessors4.attribute_options_including_superclasses[:test2].should be_present
        StorageRoom::TestAccessors4.attribute_options_including_superclasses[:test4].should be_present
        StorageRoom::TestAccessors4.attribute_options_including_superclasses[:test5].should be_present
        StorageRoom::TestAccessors4.attribute_options_including_superclasses[:test6].should be_present
      end
    end
  end
  
  
  context "Instance" do
    before(:each) do
      @test = StorageRoom::TestAccessors.new(:test => 1)
    end
    
    describe "#initialize" do    
      it "should set attributes" do
        @test.test.should == 1
        @test['test'].should be_nil
        @test.test2.should be_nil
        @test['test2'].should be_nil
      end
    end
    
    describe "#set_from_response_data" do  
      before(:each) do
        @test.set_from_response_data(:test2 => 3)
      end
        
      it "should reset attributes" do
        @test.test.should be_nil
      end
      
      it "should set new attributes" do
        @test['test2'].should == 3
        @test.test2.should == 3
      end
    end
    
    describe "#inspect" do
      it "should output string" do
        @test.inspect.should be_present
      end
    end
    
    describe "#[]" do
      it "should get attribute" do
        @test.set_from_response_data(:test2 => 3)
        
        @test[:test].should be_nil
        @test[:test2].should == 3
      end
    end
        
    describe "#attributes" do
      it "should return existing attributes" do
        @test.attributes[:test].should == 1
        @test.attributes['test'].should == 1
        @test.attributes['test2'].should be_nil
      end
    end
    
    describe "#attributes=" do
      before(:each) do
        @test.attributes = {:test => 0}
      end
      
      it "should set attributes" do
        @test.attributes[:test].should == 0
      end
    end
    
    describe "#as_json" do
      it "should return attributes as hash" do
        hash = @test.as_json
        hash.should be_an_instance_of(Hash)
        hash['test'].should == 1
      end
    end
    
    describe "#eql?" do
      it "should return true for same class and same attributes but different object ids" do
        one = StorageRoom::TestAccessors3.new(:test => 1, :test2 => '2', :test3 => ['tag1', 'tag2'], :test4 => nil, :test5 => {:key => 'value'})
        two = StorageRoom::TestAccessors3.new(:test => 1, :test2 => '2', :test3 => ['tag1', 'tag2'], :test4 => nil, :test5 => {:key => 'value'})
        
        one.eql?(two).should be_true
      end
      
      it "should return false for same class and different attributes" do
        one = StorageRoom::TestAccessors3.new(:test => 1, :test2 => '2', :test3 => ['tag1', 'tag2'], :test4 => nil, :test5 => {:key => 'value'})
        two = StorageRoom::TestAccessors3.new(:test => 1, :test2 => '2', :test3 => ['tag1', 'tag2'], :test4 => 1, :test5 => {:key => 'value'})
        
        one.eql?(two).should be_false
      end
      
      it "should return false for different classes" do
        one = StorageRoom::TestAccessors3.new(:test => 1, :test2 => '2', :test3 => ['tag1', 'tag2'], :test4 => nil, :test5 => {:key => 'value'})
        two = StorageRoom::TestAccessors2.new(:test => 1, :test2 => '2', :test3 => ['tag1', 'tag2'], :test4 => nil, :test5 => {:key => 'value'})
        
        one.eql?(two).should be_false
        one.eql?('asdf').should be_false
      end
    end
    
    describe "#hash" do
      it "should return same hash for same class and same attributes" do
        one = StorageRoom::TestAccessors3.new(:test => 1, :test2 => '2', :test3 => ['tag1', 'tag2'], :test4 => nil, :test5 => {:key => 'value'})
        two = StorageRoom::TestAccessors3.new(:test => 1, :test2 => '2', :test3 => ['tag1', 'tag2'], :test4 => nil, :test5 => {:key => 'value'})
        
        one.hash.should == two.hash
      end
      
      it "should return different hash for same class and different attributes" do
        one = StorageRoom::TestAccessors3.new(:test => 1, :test2 => '2', :test3 => ['tag1', 'tag2'], :test4 => nil, :test5 => {:key => 'value'})
        two = StorageRoom::TestAccessors3.new(:test => 1, :test2 => '2', :test3 => ['tag1', 'tag2'], :test4 => 1, :test5 => {:key => 'value'})
        
        one.hash.should_not == two.hash
      end
      
      it "should return different hash for different classes" do
        one = StorageRoom::TestAccessors3.new(:test => 1, :test2 => '2', :test3 => ['tag1', 'tag2'], :test4 => nil, :test5 => {:key => 'value'})
        two = StorageRoom::TestAccessors2.new(:test => 1, :test2 => '2', :test3 => ['tag1', 'tag2'], :test4 => nil, :test5 => {:key => 'value'})
        
        one.hash.should_not == two.hash
        one.hash.should_not == 'asdf'.hash
      end
    end
    
    describe "#reset!" do
      it "should reset" do  
        @test.response_data = {'test' => 1}      
        @test.reset!
        @test.attributes.should == {}
        @test.response_data.should == {}
      end
    end
    
    describe "#loaded?" do
      it "should return true" do
        @test.response_data = {'test' => 1}
        @test.should be_loaded
      end
      
      it "should return false" do
        @test.reset!
        @test.should_not be_loaded
      end
    end

  end
  
end
