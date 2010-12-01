require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StorageRoom::Model do
  context "Class" do    
    context "Methods" do
      describe "#show_path" do
        it "should raise" do
          lambda {
            StorageRoom::Model.show_path(1)
          }.should raise_error(StorageRoom::AbstractMethod)
        end
      end
      
      describe "#index_path" do
        it "should raise" do
          lambda {
            StorageRoom::Model.index_path
          }.should raise_error(StorageRoom::AbstractMethod)
        end
      end
      
      describe "#json_name" do
        it "should raise" do
          lambda {
            StorageRoom::Model.json_name
          }.should raise_error(StorageRoom::AbstractMethod)
        end
      end
      
      describe "#create" do
        it "should create" do
          object = stub('StorageRoom::Model')
          object.should_receive(:create)

          StorageRoom::Model.stub(:new).and_return(object)
          
          result = StorageRoom::Model.create(:one => 1, :two => 2)
          result.should == object
        end
      end
      
      describe "#all" do
        it "should load" do
          stub_request(:get, stub_url('/collections')).to_return(:body => fixture_file('collections.json'), :status => 200)
          
          array = StorageRoom::Collection.all
          array[:@type].should == 'Array'
        end
      end
      
      describe "#find" do
        it "should load" do
          stub_request(:get, stub_url('/collections/1')).to_return(:body => fixture_file('collection.json'), :status => 200)
          
          collection = StorageRoom::Collection.find(1)
          collection[:@type].should == 'Collection'
        end
      end
    end
  end
  
  context "Instance" do
    before(:each) do
      @model = StorageRoom::Model.new(:test => 1, :@attr => 2)
    end
    
    describe "#initialize" do    
      it "should set attributes" do
        @model[:test].should == 1
        @model[:@attr].should == 2
      end

      it "should set new record" do
        @model.should be_new_record
      end
      
      it "should set errors" do
        @model.errors.should == []
      end
    end
    
    describe "#set_from_api" do  
      before(:each) do
        @model.set_from_api(:test2 => 3)
      end
        
      it "should reset attributes" do
        @model[:test].should be_nil
        @model[:@attr].should be_nil
      end
      
      it "should set new attributes" do
        @model[:test2].should == 3
      end

      it "should set new record" do
        @model.should_not be_new_record
      end
    end
    
    describe "#reset!" do
      it "should reset" do
        @model.instance_variable_set(:@errors, [1,2,3])
        
        @model.reset!
        @model.attributes.should == {}
        @model.should be_new_record
        @model.errors.should == []
      end
    end
    
    describe "#valid?" do
       it "should be valid" do
         @model.should be_valid
       end

       it "should be invalid" do
         @model.errors.push(1)
         @model.should_not be_valid
       end
     end

     describe "#errors" do
       it "should have errors" do
         @model.errors.should == []
       end
     end

     describe "#new_record?" do
       it "should be new record" do
         @model.should be_new_record
         @model.instance_variable_set :@new_record, false
         @model.should_not be_new_record
       end
     end
     
     describe "#save" do
       before(:each) do
         @model.stub(:create)
         @model.stub(:update)
       end

       it "should create on new record" do
         @model.should_receive(:create)
         @model.save
       end

       it "should update on existing record" do
         @model.instance_variable_set(:@new_record, false)
         @model.should_receive(:update)
         @model.save
       end
     end

     describe "#as_json" do
       it "should return hash without meta data" do
         entry = StorageRoom::Entry.new(:field => 1, :@attr => 2)
         hash = entry.as_json

         hash['entry'][:field].should == 1
         hash['entry'][:@attr].should_not be_present
       end
     end

     describe "#reload" do
       it "should load" do
         collection = StorageRoom::Collection.new
         collection[:@url] = '/collections/1'
         stub_request(:get, stub_url('/collections/1')).to_return(:body => fixture_file('collection.json'), :status => 200)

         collection.reload
         collection[:name].should == 'Guidebooks'
       end
     end

     describe "#create" do
       it "should create" do
         klass = StorageRoom.class_for_name('Guidebook')
         guidebook = klass.new

         stub_request(:post, stub_url('/collections/guidebooks/entries')).to_return(:body => fixture_file('collection.json'), :status => 200)

         guidebook.create
         guidebook[:name].should == 'Guidebooks'
       end

       it "should have errors on validation error" do
         klass = StorageRoom.class_for_name('Guidebook')
         guidebook = klass.new

         stub_request(:post, stub_url('/collections/guidebooks/entries')).to_return(:body => fixture_file('validation_error.json'), :status => 422)

         guidebook.create
         guidebook[:name].should be_nil

         guidebook.errors.should have(1).items
       end
     end

     describe "#update" do
       it "should update" do
         collection = StorageRoom::Collection.new
         collection.instance_variable_set(:@new_record, false)
         collection[:@url] = '/collections/1'

         stub_request(:put, stub_url('/collections/1')).to_return(:body => fixture_file('collection.json'), :status => 200)

         collection.update
         collection[:name].should == 'Guidebooks'
       end

       it "should have errors on validation error" do
         collection = StorageRoom::Collection.new
         collection.instance_variable_set(:@new_record, false)
         collection[:@url] = '/collections/1'

         stub_request(:put, stub_url('/collections/1')).to_return(:body => fixture_file('validation_error.json'), :status => 422)

         collection.update
         collection[:name].should be_nil
         collection.errors.should have(1).items
       end
     end

     describe "#destroy" do
       it "should destroy" do
         collection = StorageRoom::Collection.new
         collection.instance_variable_set(:@new_record, false)
         collection[:@url] = '/collections/1'

         stub_request(:delete, stub_url('/collections/1')).to_return(:status => 200)

         collection.destroy
       end
     end
    
  end
  
end