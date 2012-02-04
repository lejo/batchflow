module BatchFlow
  module Triggers
    class Time < Base
      attr_reader :type, :name, :time, :every

      def chiming(time)
        succeed
      end

      def timing_out(time)
        fail
      end

      private

      def init_watcher
        e = Hash[@events.map {|ev| [ev, true]}]
        opts = e.merge(:every => @every)
        BatchFlow::Watchers::Time.new(@time, self, opts)
      end
    end
  end
end
