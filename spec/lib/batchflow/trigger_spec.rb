require 'spec_helper'

describe BatchFlow::Trigger do
  it "should instantiate a Time trigger" do
    BatchFlow::Trigger.new(:type => :time, :time => 5, :events => [:chime]).
      should be_an_instance_of(BatchFlow::Triggers::Time)
  end

  it "should instantiate a File trigger" do
    BatchFlow::Trigger.new(:type => :file, :path => '/some/path', :events => [:create]).
      should be_an_instance_of(BatchFlow::Triggers::File)
  end

  it "should not instantiate an invalid trigger" do
    lambda {
      BatchFlow::Trigger.new(:type => :bogus)
    }.should raise_error(NameError)
  end
end
