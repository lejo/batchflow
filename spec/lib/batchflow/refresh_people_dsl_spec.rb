require 'spec_helper'

describe BatchFlow::Dsl do
  context "refresh people cache job" do
    let('dsl') { BatchFlow::Dsl.new("spec/fixtures/jobs/refresh_people_cache.rb") }
    it { dsl.jobs.size.should == 1 }
    it { dsl.jobs.first.name.should == :refresh_people_cache }
    context "tasks" do
      let('tasks') { dsl.jobs.first.tasks }
      it { tasks.size.should == 2 }
      context "first task" do
        let('first_task') {tasks.first}
        it { first_task.name.should == :transform_file }
        context "triggers" do
          let('triggers') {first_task.triggers}
          it {triggers.size.should == 1}
          it {triggers.first.type.should == :file }
          it {triggers.first.path.should == "/path/to/people_updates.csv" }
        end
      end
      context "second task" do
        let('second_task') {tasks.last}
        it { second_task.name.should == :refresh_cache}
        context "triggers" do
          let('triggers') {second_task.triggers}
          it {triggers.size.should == 1}
          it {triggers.first.type.should == :task }
          it {triggers.first.name.should == :transform_file}
        end
      end
    end
  end
end

