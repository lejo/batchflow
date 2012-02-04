require 'spec_helper'
require 'tempfile'

describe BatchFlow::FileWatcher do
  context "deleted files" do
    let (:file) { f = Tempfile.new('file_watcher_spec'); sleep 1; f }

    it "does not trigger if not subscribed to deletes" do
      trigger = BatchFlow::FileTrigger.new(
        :type => :file,
        :path => file.path,
        :events => [:create])

      trigger.init!
      FileUtils.rm_f(file.path)

      trigger.should_not_receive(:files_deleted)
      EM.trigger_timer
    end

    it "triggers when deleted" do
      trigger = BatchFlow::FileTrigger.new(
        :type => :file,
        :path => file.path,
        :events => [:delete])

      trigger.init!
      FileUtils.rm_f(file.path)

      trigger.should_receive(:files_deleted).with([file.path])
      EM.trigger_timer
    end

    after do
      file.unlink
    end
  end

  context "modified files" do
    let (:file) { f = Tempfile.new('file_watcher_spec'); sleep 1; f }

    it "does not trigger if not subscribed to edits" do
      trigger = BatchFlow::FileTrigger.new(
        :type => :file,
        :path => file.path,
        :events => [:create])

      trigger.init!
      file << "some content"
      file.close

      trigger.should_not_receive(:files_modified)
      EM.trigger_timer
    end

    it "triggers when modified" do
      trigger = BatchFlow::FileTrigger.new(
        :type => :file,
        :path => file.path,
        :events => [:modify])

      trigger.init!
      file << "some content"
      file.close

      trigger.should_receive(:files_modified).with([file.path])
      EM.trigger_timer
    end

    after do
      file.unlink
    end
  end

  context "new files" do
    it "does not trigger if not subscribed to creates" do
      path = File.join(Dir.tmpdir, "*watcher_create_spec*")
      trigger = BatchFlow::FileTrigger.new(
        :type => :file,
        :path => path,
        :events => [:modify])

      trigger.init!
      f = Tempfile.new("watcher_create_spec")
      f.close

      trigger.should_not_receive(:files_created)
      EM.trigger_timer

      f.unlink
    end

    it "triggers when created" do
      t = Time.now.to_i
      path = File.join(Dir.tmpdir, "#{t}*")
      trigger = BatchFlow::FileTrigger.new(
        :type => :file,
        :path => path,
        :events => [:create])

      trigger.init!
      f = Tempfile.new(t.to_s)
      f.close

      trigger.should_receive(:files_created).with([f.path])
      EM.trigger_timer

      f.unlink
    end
  end
end
