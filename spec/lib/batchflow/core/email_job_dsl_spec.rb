require 'spec_helper'

describe BatchFlow::Core::Dsl do
  context "the people csv ingestion dsl" do
    let('dsl') { BatchFlow::Core::Dsl.new("spec/fixtures/jobs/email_people_csv.rb") }
    it { dsl.jobs.size.should == 1 }
    it { dsl.jobs.first.name.should == "email people csv" }
    context "tasks" do
      let('tasks') { dsl.jobs.first.tasks }
      it { tasks.size.should == 1 }
      context "first task" do
        let('first_task') {tasks.first}
        it { first_task.name.should == "email when present" }
        context "triggers" do
          let('triggers') {first_task.triggers}
          it {triggers.size.should == 1}
          it {triggers.first.class.should == BatchFlow::Triggers::File }
          it {triggers.first.path.should == "/path/to/people.csv" }
          it {triggers.first.events.should == [:create]}
        end
      end
    end
  end
end

