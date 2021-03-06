module BatchFlow
  module Triggers
    class File < Base
      attr_reader :type, :name, :path, :events

      def files_modified(paths)
        succeed
      end

      def files_deleted(paths)
        succeed
      end

      def files_created(paths)
        succeed
      end

      private

      def init_watcher
        e = Hash[@events.map {|ev| [ev, true]}]
        BatchFlow::Watchers::File.new(@path, self, e)
      end
    end
  end
end
