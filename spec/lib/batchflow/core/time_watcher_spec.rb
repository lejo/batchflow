require 'spec_helper'
require "em-spec/rspec"

describe BatchFlow::TimeWatcher do
  include EM::SpecHelper
  context "absolute one-time trigger" do
    let (:time) do
      Time.now + 3
    end

    it "triggers when time reached" do
      trigger = BatchFlow::Trigger.new(
        :type => :time,
        :time => time,
        :events => [:chime])

      trigger.should_receive(:chiming).with(time)
      with_em(trigger) do
        trigger.init!
      end
    end
  end

  context "recurring time trigger" do
    let (:time) do
      Time.now + 2
    end

    it "triggers every two seconds" do
      trigger = BatchFlow::Trigger.new(
        :type => :time,
        :time => time,
        :events => [:chime],
        :every => 2)

      trigger.should_receive(:chiming).twice
      with_em(trigger) do
        trigger.init!
      end
    end
  end

  context "timeout trigger" do
    let (:time) do
      Time.now + 2
    end

    it "should time out at a given time" do
      trigger = BatchFlow::Trigger.new(
        :type => :time,
        :time => time,
        :events => [:timeout])

      trigger.should_receive(:timing_out)
      with_em(trigger) do
        trigger.init!
      end
    end
  end

  def with_em(trigger)
    em do
      trigger.callback { EM.stop }
      trigger.timeout(5)
      trigger.errback { EM.stop }
      yield
    end
  end

end
