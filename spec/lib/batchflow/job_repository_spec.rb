require 'spec_helper'

describe BatchFlow::JobRepository do

  JOBS_PATH = File.join(File.dirname(__FILE__), '..', '..', 'fixtures', 'jobs')
  let(:repository) {BatchFlow::JobRepository.new(:jobs_path => JOBS_PATH)}

  context "file_paths" do
    it "returns all paths across jobs" do
      repository.file_paths.should ==  ["/path/to/people.csv", "/path/to/people_updates.csv"]
    end
  end

  context "jobs" do
    it "loads all jobs" do
      repository.jobs.size.should == 3
    end
  end

  context "schedules" do

  end

  context "timers" do

  end

  context "events" do

  end
end
