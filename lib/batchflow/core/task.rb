module BatchFlow
  class Task
    attr_reader :name
    def initialize(attrs)
      attrs.each_pair {|k,v| instance_variable_set "@#{k}".to_sym, v}
    end
  end
end
