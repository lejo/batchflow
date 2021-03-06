require 'spec_helper'

describe BatchFlow::Watchers::Time do
  context "absolute one-time trigger" do
    let (:time) { 3 }
    it "triggers when time reached" do
      trigger = BatchFlow::Triggers::Time.new(
        :time   => time,
        :events => [:chime])

      Time.stub(:now).and_return(time)
      trigger.should_receive(:chiming).with(time)
      trigger.init!
    end
  end

  context "recurring time trigger" do
    let (:time) {0}
    it "triggers every two seconds" do
      trigger = BatchFlow::Triggers::Time.new(
        :time   => 0,
        :events => [:chime],
        :every  => 2)

      Time.should_receive(:now).exactly(3).times.and_return(0, 2, 8)
      trigger.should_receive(:chiming).twice

      trigger.init!
    end
  end

  context "timeout trigger" do
    let ('time') { 0 }
    it "should time out at a given time" do
      trigger = BatchFlow::Triggers::Time.new(
        :time   => time + 2,
        :events => [:timeout])

      Time.stub(:now).and_return(time + 1, time + 2)

      trigger.should_receive(:timing_out)
      trigger.init!
    end
  end
end
