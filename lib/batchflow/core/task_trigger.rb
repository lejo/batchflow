module BatchFlow
  class TaskTrigger < Trigger
    attr_reader :type, :name, :events

    private

    def init_watcher
      e = Hash[@events.map {|ev| [ev, true]}]
      BatchFlow::FileWatcher.new(@path, self, e)
    end
  end
end

