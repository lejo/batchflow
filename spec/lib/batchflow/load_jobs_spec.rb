require 'spec_helper'

describe BatchFlow::LoadJobs do
  context "a simple job" do
    let('job') { BatchFlow::LoadJobs.new(:jobs => ["spec/fixtures/jobs/alert.rb"]).jobs.first }
    it { job.name.should == "simple job" }
    context "triggers" do
      xit { job.triggers.size.should == 2 }
    end
  end
end
