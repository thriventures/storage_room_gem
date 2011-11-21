require 'spec_helper'

class Recipe < StorageRoom::Entry
  key :name
end

describe StorageRoom::IdentityMap do
  before(:each) do
    @response_data = {'@url' => 'URL', '@type' => 'Recipe', 'name' => 'NAME'}
    
    @recipe = Recipe.new_from_response_data(@response_data)
  end
  
  context "Module Methods" do
    describe "#models" do
      it "should return set" do
        set = StorageRoom::IdentityMap.models
        set.should be_an_instance_of(::Set)
        set.should include(StorageRoom::Resource)
      end
    end
    
    describe "#clear" do
      it "should remove objects" do
        StorageRoom::Resource.identity_map['URL'] = 1
        StorageRoom::Resource.identity_map.should have(1).item

        StorageRoom::IdentityMap.clear
        StorageRoom::Resource.identity_map.should have(0).items
      end
    end
  end
  
  context "Class Methods" do
    describe "#new_from_response_data" do
      it "should return existing object from identity map" do
        response_data = {'@url' => 'URL', '@type' => 'Recipe'}
        
        recipe = Recipe.new_from_response_data(response_data)
        recipe.should == @recipe
        recipe.name.should == 'NAME'
      end
      
      it "should return new object" do
        response_data = {'@url' => 'URL2', '@type' => 'Recipe', 'name' => 'NAME2'}
        
        recipe = Recipe.new_from_response_data(response_data)
        recipe.should_not == @recipe
        recipe.name.should == 'NAME2'
      end
    end
  end
end
