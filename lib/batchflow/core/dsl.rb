module BatchFlow
  module Core
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
        job_dsl = JobDsl.new(name, &block)
        tasks = job_dsl.tasks
        @jobs << BatchFlow::Core::Job.new(
          :name  => name,
          :tasks => tasks
        )
        setup_task_triggers(tasks)
      end

      def setup_task_triggers(tasks)
        task_triggers = tasks.map(&:triggers).flatten.select { |t| t.type == :task }
        tasks_hash = Hash[tasks.map { |t| [t.name, t] }]
        task_triggers.each { |t| t.set_dependent_task(tasks_hash[t.name]) }
      end
    end

    class JobDsl
      attr_reader :tasks
      def initialize(job_name, &block)
        @tasks = []
        @job_name = job_name
        self.instance_eval &block if block_given?
      end

      def task(name, &block)
        task_dsl = TaskDsl.new(&block)
        @tasks << BatchFlow::Core::Task.new(
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
      def initialize(&block)
        @triggers = []
        self.instance_eval &block if block_given?
      end

      def triggered_by(params)
        type = params[:type]
        if type == :file
          @triggers << BatchFlow::Triggers::File.new(params)
        elsif type == :timer
          @triggers << BatchFlow::Triggers::Time.new(params)
        elsif type == :task
          @triggers << BatchFlow::Triggers::Task.new(params)
        end
      end

      def triggered_by_file(path, events)
        events = if events
          if !events.is_a?(Array)
            [events]
          else
            events
          end
        else
          [:create, :modify, :delete]
        end
        triggered_by({:type => :file, :path => path, :events => events})
      end

      def triggered_at(time)
        triggered_by({:type => :timer, :time => time})
      end

      def triggered_by_task(name)
        triggered_by({:type => :task, :name => name})
      end

      def triggered_every(every)
        triggered_by({:type => :timer, :every => every})
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
end
