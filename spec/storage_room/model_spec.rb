require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

class Contributor < StorageRoom::Entry
  
end

class Author < StorageRoom::Entry
  
end

class Recipe < StorageRoom::Entry
  key :name
  key :ingredients
  
  one :author
  many :contributors
end



describe StorageRoom::Model do
  before(:each) do    
    @model = Recipe.new(:name => 'NAME')
  end
  
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
    describe "#initialize" do    
      it "should set attributes" do
        @model.name.should == 'NAME'
      end

      it "should set new record" do
        @model.should be_new_record
      end
      
      it "should set errors" do
        @model.errors.should == []
      end
    end
    
    describe "#set_from_response_data" do  
      before(:each) do
        @model.set_from_response_data('ingredients' => 'INGREDIENTS', '@version' => 2)
      end
        
      it "should reset attributes" do
        @model.name.should be_nil
      end
      
      it "should set new attributes" do
        @model.ingredients.should == 'INGREDIENTS'
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
       it "should return true" do
         @model.should be_new_record
       end
       
       it "should return false" do
         @model.response_data['@version'] = 3
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
         @model.stub(:new_record?).and_return(false)
         @model.should_receive(:update)
         @model.save
       end
     end

     describe "#as_json" do
       it "should return hash" do
         contributor = Contributor.new
         contributor.response_data[:@url] = "CONTRIBUTOR_URL"
         
         author = Author.new
         author.response_data[:@url] = "AUTHOR_URL"
         
         entry = Recipe.new(:name => "NAME", :ingredients => "INGREDIENTS", :contributors => [contributor], :author => author)
         hash = entry.as_json

         hash['entry']['name'].should == "NAME"
         hash['entry']['ingredients'].should == "INGREDIENTS"
         hash['entry']['author']['url'].should == 'AUTHOR_URL'
         hash['entry']['contributors'][0].should == {'url' => 'CONTRIBUTOR_URL'}
       end
     end

     describe "#reload" do
       it "should load" do
         collection = StorageRoom::Collection.new
         collection.response_data[:@url] = '/collections/1'
         stub_request(:get, stub_url('/collections/1')).to_return(:body => fixture_file('collection.json'), :status => 200)

         collection.reload
         collection[:name].should == 'Guidebooks'
       end
     end

     describe "#create" do
       it "should create" do
         guidebooks = StorageRoom::Collection.new
         stub_request(:post, stub_url('/collections')).to_return(:body => fixture_file('collection.json'), :status => 201)
         
         guidebooks.create
         guidebooks.should_not be_new_record
       end

       it "should have errors on validation error" do
         guidebooks = StorageRoom::Collection.new

         stub_request(:post, stub_url('/collections')).to_return(:body => fixture_file('validation_error.json'), :status => 422)

         guidebooks.create
         guidebooks.should be_new_record

         guidebooks.errors.should have(1).items
       end
     end

     describe "#update" do
       before(:each) do
         @collection = StorageRoom::Collection.new
         @collection.response_data[:@url] = '/collections/1'
         @collection.response_data[:@version] = 1
       end
       
       it "should update" do
         stub_request(:put, stub_url('/collections/1')).to_return(:body => fixture_file('collection.json'), :status => 200)

         @collection.update
         @collection.response_data[:@version].should == 2
       end

       it "should have errors on validation error" do
         stub_request(:put, stub_url('/collections/1')).to_return(:body => fixture_file('validation_error.json'), :status => 422)

         @collection.update
         @collection.response_data[:@version].should == 1
         @collection.errors.should have(1).items
       end
     end

     describe "#destroy" do
       it "should destroy" do
         collection = StorageRoom::Collection.new
         collection.response_data[:@url] = '/collections/1'
         collection.response_data[:@version] = 1

         stub_request(:delete, stub_url('/collections/1')).to_return(:status => 200)

         collection.destroy
       end
     end
    
  end
  
end