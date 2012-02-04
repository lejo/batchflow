module BatchFlow
  module Triggers
    class Task < Base
      attr_reader :type, :name, :events

      private

      def init_watcher
        e = Hash[@events.map {|ev| [ev, true]}]
        BatchFlow::Watchers::File.new(@path, self, e)
      end
    end
  end
end
