module BatchFlow
  class Engine
    attr_reader :jobs

    def initialize(opts = {})
      @opts = opts
      @jobs = []
    end
  end
end
