require 'spec_helper'

describe BatchFlow::Core::Dsl do
  context "the people ingestion dsl" do
    let('dsl') { BatchFlow::Core::Dsl.new("spec/fixtures/jobs/people.rb") }
    it { dsl.jobs.size.should == 1 }
    it { dsl.jobs.first.name.should == :people }

    context "tasks" do
      let('tasks') { dsl.jobs.first.tasks }
      it { tasks.size.should == 5 }

      context "ingest task" do
        let('ingest_task') {tasks.first}
        it { ingest_task.name.should == :ingest }
        context "triggers" do
          let('triggers') {ingest_task.triggers}
          it {triggers.size.should == 2}
          it {triggers.first.type.should == :file }
          it {triggers.first.path.should == "/tmp/people.csv" }
          it {triggers.first.events.should == [:modify]}

          it {triggers.last.type.should == :file }
          it {triggers.last.path.should == "/tmp/people_friends.csv" }
          it {triggers.last.events.should == [:modify]}
        end
      end

      context "ingestion_overrun_notifier task" do
        let('overun_task') {tasks[1]}
        it { overun_task.name.should == :ingestion_overun_notifier }
        context "triggers" do
          let('triggers') {overun_task.triggers}
          it {triggers.size.should == 1}
          it {triggers.first.type.should == :timer }
          it {triggers.first.time.should == "10.am" }
        end
      end

      context "index task" do
        let('index_task') {tasks[2]}
        context "triggers" do
          let('triggers') {index_task.triggers}
          it {triggers.size.should == 1}
          it {triggers.first.type.should == :task }
          it {triggers.first.name.should == :ingest }
        end
      end

      context "people_location_mappings task" do
        let('mappings_task') {tasks[3]}
        context "triggers" do
          let('triggers') {mappings_task.triggers}
          it {triggers.size.should == 1}
          it {triggers.first.type.should == :task }
          it {triggers.first.name.should == :ingest }
        end
      end

      context "generate_timeline task" do
        let('timeline_task') {tasks[4]}
        context "triggers" do
          let('triggers') {timeline_task.triggers}
          it {triggers.size.should == 3}
          it {triggers.first.type.should == :task }
          it {triggers.first.name.should == :ingest }
          it {triggers[1].type.should == :task }
          it {triggers[1].name.should == :index }
          it {triggers[2].type.should == :task }
          it {triggers[2].name.should == :people_location_mappings }
        end
      end

    end
  end
end
