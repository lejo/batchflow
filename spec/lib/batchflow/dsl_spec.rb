require 'spec_helper'

describe BatchFlow::Dsl do
  context "the alert job" do
    let('dsl') { BatchFlow::Dsl.new("spec/fixtures/jobs/alert.rb") }
    it { dsl.jobs.size.should == 1 }
    it { dsl.jobs.first.name.should == "simple job" }
    context "tasks" do
      let('tasks') { dsl.jobs.first.tasks }
      it { tasks.size.should == 2 }
      context "first task" do
        let('first_task') {tasks.first}
        it { first_task.name.should == "wait for file" }
        context "triggers" do
          let('triggers') {first_task.triggers}
          it {triggers.size.should == 1}
          it {triggers.first.type.should == :file }
          it {triggers.first.path.should == "/path/to/file" }
          it {triggers.first.events.should == [:create]}
        end
      end
      context "second task" do
        let('second_task') {tasks.last}
        it { second_task.name.should == "read file" }
        context "triggers" do
          let('triggers') {second_task.triggers}
          it {triggers.size.should == 1}
          it {triggers.first.type.should == :task }
          it {triggers.first.name.should == "wait for file" }
        end
      end
    end
  end
end
