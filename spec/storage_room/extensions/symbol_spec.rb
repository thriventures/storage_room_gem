require 'spec_helper'

require 'storage_room/extensions/symbol'

describe StorageRoom::Extensions::Symbol do
  it "should transform a known symbol with operator to string" do
    :something.in.to_s.should == 'something!in'
  end
  
  it "should raise an error for an unknown operator" do
    lambda {
      :something.asdf
    }.should raise_error(NoMethodError)
  end
end
