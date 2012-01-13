module BatchFlow
  class Dsl
    attr_reader :jobs
    def initialize(job_spec)
      @jobs, @triggers = [],[],[]
      [eval(File.read(File.expand_path(job_spec)))]
    end

    def job(name, &block)
      j = BatchFlow::Job.new(:name => name,
                             :tasks => TaskDsl.new(&block).tasks)
      @jobs << j
    end
  end

  class TaskDsl
    attr_reader :tasks
    def initialize
      @tasks = []
      yield self
    end

    def task(name, &block)
      @tasks << BatchFlow::Task.new(:name => name,
                                    :triggers => TriggerDsl.new(&block).triggers)
    end
  end

  class TriggerDsl
    attr_reader :triggers
    def initialize
      @triggers = []
      yield self
    end

    def triggered_by(params)
      @triggers << BatchFlow::Trigger.new(params)
    end
  end
end
