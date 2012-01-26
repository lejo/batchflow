module BatchFlow
  class Engine
    def self.run
      set_em_opts
      @job_repo = BatchFlow::JobRepository.new

      EM.run do
        @job_repo.init!
      end
    end

    private

    def self.set_em_opts
      EM.kqueue = true
    end
  end
end
