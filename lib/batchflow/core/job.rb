module BatchFlow
  class Job
    attr_reader :tasks, :name
    def initialize(attrs)
      @tasks = []
      attrs.each_pair {|k,v| instance_variable_set "@#{k}".to_sym, v}
    end
  end
end
