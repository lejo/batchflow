module BatchFlow
  class Trigger
    include EM::Deferrable
    attr_reader :type, :path, :events, :name, :time, :every

    def initialize(attrs)
      attrs.each_pair {|k,v| instance_variable_set "@#{k}".to_sym, v}
    end

    def init!
      init_watcher
    end

    def ready?
      @deferred_status == :succeeded
    end

    def files_modified(paths)
      puts "fired"
      succeed
    end

    def files_deleted(paths)
      succeed
    end

    def files_created(paths)
      succeed
    end

    def chiming(time)
      puts "chiming fired"
      succeed
    end

    def timing_out(time)
      puts "timeout fired"
      fail
    end

    private

    def init_watcher
      if @type == :file
        e = Hash[@events.map {|ev| [ev, true]}]
        BatchFlow::FileWatcher.new(@path, self, e)
      elsif @type == :time
        e = Hash[@events.map {|ev| [ev, true]}]
        #puts "time trigger with args #{e.inspect}"
        opts = e.merge(:every => @every)
        BatchFlow::TimeWatcher.new(@time, self, opts)
      end
    end

  end
end
