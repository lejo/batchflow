module BatchFlow
  class Task
    attr_reader :name, :triggers, :runs, :on_error, :execute
    def initialize(attrs)
      attrs.each_pair {|k,v| instance_variable_set "@#{k}".to_sym, v}
    end
  end
end

