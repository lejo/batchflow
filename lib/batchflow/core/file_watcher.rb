module BatchFlow
  class FileWatcher < EM::FileWatch
    def initialize(trigger)
      @trigger = trigger
    end

    def file_modified
      @trigger.succeed
    end
  end
end
