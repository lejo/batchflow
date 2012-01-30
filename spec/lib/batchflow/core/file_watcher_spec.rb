require 'spec_helper'
require 'tempfile'
require "em-spec/rspec"

describe BatchFlow::FileWatcher do
  include EM::SpecHelper
  context "modified files" do
    let (:file) do
      f = Tempfile.new('file_watcher_spec')
      sleep 1 # wait for mtime
      f
    end

    it "does not trigger if not subscribed to edits" do
      trigger = BatchFlow::Trigger.new(
        :type => :file,
        :path => file.path,
        :events => [:create])

      trigger.should_not_receive(:files_modified)
      with_em(trigger) do
        trigger.init!
        sleep 1
      end
    end

    it "triggers when modified" do
      trigger = BatchFlow::Trigger.new(
        :type => :file,
        :path => file.path,
        :events => [:modify])

      trigger.should_receive(:files_modified).with([file.path])

      with_em(trigger) do
        trigger.init!
        sleep 1
        file << "some content"
        file.close
      end
    end

    after do
      file.close
      file.unlink
    end

  end

  context "new files" do
    it "does not trigger if not subscribed to creates" do
      path = File.join(Dir.tmpdir, "*watcher_create_spec*")
      trigger = BatchFlow::Trigger.new(
        :type => :file,
        :path => path,
        :events => [:modify])

      trigger.should_not_receive(:files_created)
      with_em(trigger) do
        trigger.init!
        f = Tempfile.new("watcher_create_spec")
        f.close
        f.unlink
      end
    end

    xit "triggers when created" do
      t = Time.now.to_i
      path = File.join(Dir.tmpdir, "#{t}*")
      trigger = BatchFlow::Trigger.new(
        :type => :file,
        :path => path,
        :events => [:create])

      trigger.should_receive(:files_created)
      with_em(trigger) do
        trigger.init!
        f = Tempfile.new(t.to_s)
        sleep 1
        f.close
        f.unlink
      end
    end
  end

  def with_em(trigger)
    em do
      trigger.callback { EM.stop }
      trigger.timeout(2)
      trigger.errback { EM.stop }
      yield
    end
  end
end
