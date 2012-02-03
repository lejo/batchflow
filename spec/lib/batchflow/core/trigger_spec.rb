require 'spec_helper'

describe BatchFlow::Trigger do

  context "file-type trigger" do
    it "should create a new FileWatcher" do
      BatchFlow::FileWatcher.should_receive(:new)
      trigger_opts = {
        :type => :file,
        :path => "/path/to/file",
        :events => [:modify]
      }
      t = BatchFlow::Trigger.new(trigger_opts)
      t.init!
    end
  end

end
