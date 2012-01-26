module BatchFlow
  class Job
    include EM::Deferrable
    attr_reader :tasks, :name

    def initialize(attrs)
      attrs.each_pair {|k,v| instance_variable_set "@#{k}".to_sym, v}
    end

    def init!
      init_callbacks
      init_tasks
    end

    private

    def init_callbacks
      @tasks.each do |task|
        task.callback do
          if @tasks.all? { |t| t.ready? }
            complete!
          end
        end
      end
    end

    def init_tasks
      @tasks.map(&:init!)
    end

    def complete!
      puts "job done"
    end
  end
end
