module BatchFlow
  module Watchers
    class File

      def initialize(path, trigger, opts = {})
        @path       = path
        @trigger    = trigger
        @create     = opts[:create] == true
        @modify     = opts[:modify] == true
        @delete     = opts[:delete] == true
        @file_stats = gather_stats

        EM.add_periodic_timer(0.5) do
          stats = gather_stats
          notify(stats)
          @file_stats = stats
        end
      end

      def gather_stats
        stats = Dir.glob(@path).map{ |f| [f, ::File.stat(f)] }
        Hash[stats]
      end

      private

      def notify(stats)
        EM.schedule do
          fire(new_files(stats), modified_files(stats), deleted_files(stats))
        end
      end

      def modified_files(new_stats)
        if @modify
          files = (@file_stats.keys & new_stats.keys)
          files.select { |f| new_stats[f].mtime > @file_stats[f].mtime }
        else
          []
        end
      end

      def new_files(new_stats)
        if @create
          new_stats.keys - @file_stats.keys
        else
          []
        end
      end

      def deleted_files(new_stats)
        if @delete
          @file_stats.keys - new_stats.keys
        else
          []
        end
      end

      def fire(n_files, m_files, d_files)
        @trigger.files_created(n_files) if n_files.any?
        @trigger.files_deleted(d_files) if d_files.any?
        @trigger.files_modified(m_files) if m_files.any?
      end
    end
  end
end
