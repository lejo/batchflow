require 'spec_helper'

describe 'Trigger' do
  context "file-type trigger" do
    it "should create a new File Watcher" do
      BatchFlow::Watchers::File.should_receive(:new)
      trigger_opts = {
        :path => "/path/to/file",
        :events => [:modify]
      }
      t = BatchFlow::Triggers::File.new(trigger_opts)
      t.init!
    end
  end

  context "time-type trigger" do
    it "should create a new Time Watcher" do
      BatchFlow::Watchers::Time.should_receive(:new)
      trigger_opts = {
        :time => Time.now,
        :events => [:chime]
      }
      t = BatchFlow::Triggers::Time.new(trigger_opts)
      t.init!
    end
  end

end
