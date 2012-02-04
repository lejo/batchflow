module BatchFlow
  class Trigger
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

