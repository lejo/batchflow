module BatchFlow
  module Core
    class Task
      include EM::Deferrable
      attr_reader :name, :triggers, :runs, :on_error

      def initialize(attrs)
        attrs.each_pair {|k,v| instance_variable_set "@#{k}".to_sym, v}
      end

      def init!
        discover_task_payload_klass
        init_callbacks
        init_triggers
      end

      def ready?
        @deferred_status == :succeeded
      end

      private

      def init_callbacks
        @triggers.each do |trigger|
          trigger.callback do
            if @triggers.all? { |t| t.ready? }
              complete!
            end
          end
        end
      end

      def discover_task_payload_klass
        job_module_name = @job_name.to_s.split('_').map(&:capitalize).join
        payload_klass_name = @name.to_s.split('_').map(&:capitalize).join

        begin
          job_module = BatchFlow::Payloads.const_get(job_module_name.to_sym)
          @payload_klass = job_module.const_get(payload_klass_name.to_sym)
        rescue NameError
          raise "Could not locate task payload class for #{@job_name}::#{@name}" unless @payload_klass
        end
      end

      def init_triggers
        @triggers.map(&:init!)
      end

      def complete!
        run = lambda do
          @payload_klass.run
        end
        suc = lambda do |result|
          succeed
        end

        EM.defer(run, suc)
      end
    end
  end
end
