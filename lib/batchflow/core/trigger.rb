module BatchFlow
  class Trigger
    include EM::Deferrable
    attr_reader :type, :path, :events, :name

    def initialize(attrs)
      attrs.each_pair {|k,v| instance_variable_set "@#{k}".to_sym, v}
    end

    def init!
      init_watcher
    end

    def ready?
      @deferred_status == :succeeded
    end

    private

    def init_watcher
      if @type == :file
        EM::watch_file(@path, BatchFlow::FileWatcher, self)
      end
    end

  end
end
