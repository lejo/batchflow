module BatchFlow
  class Dsl
    attr_reader :jobs
    def initialize(job_spec)
      @jobs = []
      @tasks = []
      [eval(File.read(File.expand_path(job_spec)))]
    end

    def job(name, &block)
      block.call
      j = BatchFlow::Job.new(:name => name, :tasks => @tasks)
      @jobs << j
    end

    def task(name, &block)
      @tasks << BatchFlow::Task.new(:name => name)
    end
  end
end
