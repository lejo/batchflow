module BatchFlow
  class Dsl
    attr_reader :jobs
    def initialize(job_specs)
      @jobs = []
      job_specs = job_specs.is_a?(Array) ? job_specs : [job_specs]
      job_specs.each do |job_spec|
        eval(File.read(File.expand_path(job_spec)))
      end
    end

    def job(name, &block)
      @jobs << BatchFlow::Job.new(
        :name  => name,
        :tasks => JobDsl.new(name, &block).tasks
      )
    end
  end

  class JobDsl
    attr_reader :tasks
    def initialize(job_name)
      @tasks = []
      @job_name = job_name
      yield self
    end

    def task(name, &block)
      task_dsl = TaskDsl.new(&block)
      @tasks << BatchFlow::Task.new(
        :name     => name,
        :job_name => @job_name,
        :triggers => task_dsl.triggers,
        :execute  => task_dsl.execution_config,
        :on_error => task_dsl.on_error_config,
        :runs     => task_dsl.run_config
      )
    end
  end

  class TaskDsl
    attr_reader :triggers, :run_config, :on_error_config, :execution_config
    def initialize
      @triggers = []
      yield self
    end

    def triggered_by(params)
      @triggers << BatchFlow::Trigger.new(params)
    end

    def runs(run_config)
      @run_config = run_config
    end

    def on_error(error_config)
      @on_error_config = error_config
    end

    def execute(execution_config)
      @execution_config = execution_config
    end
  end
end
