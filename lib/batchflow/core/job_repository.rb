module BatchFlow
  module Core
    class JobRepository
      JOBS_PATH = File.join(File.dirname(__FILE__), '..', '..', 'jobs')
      attr_reader :jobs

      def initialize(options = {})
        @options = options
        load_jobs(options[:jobs_path] || JOBS_PATH)
      end

      def init!
        @jobs.map(&:init!)
      end

      private

      def load_jobs(jobs_path)
        @jobs = BatchFlow::Core::Dsl.new(Dir.glob(jobs_path + "/*")).jobs
      end
    end
  end
end
