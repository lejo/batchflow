module BatchFlow
  class LoadJobs
    def initialize(opts = {})
      @opts = opts
      @jobs = []
      parse_jobs
    end

    def jobs
      @jobs
    end

    private

    def parse_jobs
      @opts[:jobs].each do |job_spec|
        eval(File.read(File.expand_path(job_spec)))
      end
    end

    def job(name)
      @jobs << Job.new(:name => name.to_s)
    end
  end
end
