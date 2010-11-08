require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module StorageRoom
  class TestAttributes
    include Attributes
  end
end

describe StorageRoom::TestAttributes do
  
  context "Instance" do
    before(:each) do
      @test = StorageRoom::TestAttributes.new(:test => 1, :@attr => 2)
    end
    
    describe "#initialize" do    
      it "should set attributes" do
        @test[:test].should == 1
        @test[:@attr].should == 2
      end
    end
    
    describe "#set_from_api" do  
      before(:each) do
        @test.set_from_api(:test2 => 3)
      end
        
      it "should reset attributes" do
        @test[:test].should be_nil
        @test[:@attr].should be_nil
      end
      
      it "should set new attributes" do
        @test[:test2].should == 3
      end
    end
    
    describe "#[]" do
      it "should get attribute" do
        @test[:test].should == 1
        @test[:@attr].should == 2
      end
    end
    
    describe "#[]=" do
      it "should set attribute" do
        @test[:test3] = 5
        @test[:test3].should == 5
      end
    end
    
    describe "#attributes" do
      it "should return existing attributes" do
        @test.attributes[:test].should == 1
        @test.attributes['test'].should == 1
        @test.attributes[:@attr].should == 2
        @test.attributes['@attr'].should == 2
      end
    end
    
    describe "#attributes=" do
      before(:each) do
        @test.attributes = {:new => 8, :test => 0}
      end
      
      it "should set attributes" do
        @test.attributes[:new].should == 8
        @test.attributes[:test].should == 0
        @test.attributes[:@attr].should == 2
      end
    end
    
    describe "#reset!" do
      it "should reset" do        
        @test.reset!
        @test.attributes.should == {}
      end
    end

  end
  
end
