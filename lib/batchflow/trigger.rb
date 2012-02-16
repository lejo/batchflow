module BatchFlow
  class Trigger
    def self.new(opts)
      type = opts.delete(:type)
      raise ArgumentError if type.nil?
      klass = BatchFlow::Triggers.const_get(type.capitalize)
      raise ArgumentError unless klass.is_a?(Class)

      klass.new(opts)
    end
  end
end
