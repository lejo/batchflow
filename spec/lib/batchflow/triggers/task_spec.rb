require 'spec_helper'

describe BatchFlow::Triggers::Task do
  it 'observes its dependent task' do
    task_trigger = BatchFlow::Triggers::Task.new(:name => :b)

    file = BatchFlow::Triggers::File.new(:path => "manually_triggered", :events => [])
    task = BatchFlow::Core::Task.new(:name => :b, :job_name => :test_payload, :triggers => [file])

    task_trigger.set_dependent_task(task)
    task_trigger.init!
    task.init!

    task_trigger.should_not be_ready

    file.succeed

    task_trigger.should be_ready
  end
end

module TestPayload
  class B
    def self.run
    end
  end
  class A
    def self.run
    end
  end
end
