module BatchFlow
  module Triggers
    class Task < Base
      attr_reader :type, :name, :events

      def set_dependent_task(task)
        @dependent_task = task
      end

      private

      def init_watcher
        @dependent_task.callback do
          succeed
        end
      end
    end
  end
end
