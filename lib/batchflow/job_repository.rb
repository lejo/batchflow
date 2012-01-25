module BatchFlow
  class JobRepository
    JOBS_PATH = File.join(File.dirname(__FILE__), '..', '..', 'jobs')
    attr_reader :jobs

    def initialize(options = {})
      @options = options
      load_jobs(options[:jobs_path] || JOBS_PATH)
    end

    def file_paths
      triggers = @jobs.map(&:tasks).flatten.map(&:triggers).flatten
      triggers.select {|t| t.type == :file}.map(&:path).uniq
    end

    private

    def load_jobs(jobs_path)
      @jobs = BatchFlow::Dsl.new(Dir.glob(jobs_path + "/*")).jobs
    end
  end
end
