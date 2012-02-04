module BatchFlow
  module Triggers
    class Base
      include EM::Deferrable
      include BatchFlow::HashInitializer

      def init!
        init_watcher
      end

      def ready?
        @deferred_status == :succeeded
      end
    end
  end
end

