require 'spec_helper'

describe BatchFlow::JobRepository do

  JOBS_PATH = File.join(File.dirname(__FILE__), '..', '..', 'fixtures', 'jobs')
  let(:repository) {BatchFlow::JobRepository.new(:jobs_path => JOBS_PATH)}

  context "jobs" do
    it "loads all jobs" do
      repository.jobs.size.should == 3
    end
  end
end
