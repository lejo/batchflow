require 'spec_helper'

describe 'BatchFlow::Trigger' do
  context "file-type trigger" do
    it "should create a new FileWatcher" do
      BatchFlow::FileWatcher.should_receive(:new)
      trigger_opts = {
        :type => :file,
        :path => "/path/to/file",
        :events => [:modify]
      }
      t = BatchFlow::FileTrigger.new(trigger_opts)
      t.init!
    end
  end

  context "time-type trigger" do
    it "should create a new TimeWatcher" do
      BatchFlow::TimeWatcher.should_receive(:new)
      trigger_opts = {
        :type => :time,
        :time => Time.now,
        :events => [:chime]
      }
      t = BatchFlow::TimerTrigger.new(trigger_opts)
      t.init!
    end
  end

end
