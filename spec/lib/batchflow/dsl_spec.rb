require 'spec_helper'

describe BatchFlow::Dsl do
  context "a simple job" do
    let('dsl') { BatchFlow::Dsl.new("spec/fixtures/jobs/alert.rb") }
    it { dsl.jobs.size.should == 1 }
    it { dsl.jobs.first.name.should == "simple job" }
    context "tasks" do
      let('tasks') { dsl.jobs.first.tasks }
      it { tasks.size.should == 2 }
      it { tasks.first.name.should == "wait for file" }
      it { tasks.last.name.should == "read file" }
    end
    context "triggers" do
      xit { job.triggers.size.should == 2 }
    end
  end
end
