module BatchFlow
  module Watchers
    class Time

      def initialize(time, trigger, opts = {})
        @time       = time
        @trigger    = trigger
        @chime      = opts[:chime] == true
        @timeout    = opts[:timeout] == true
        @interval   = opts[:every]

        add_chime_at(time)
      end

      private

      def add_chime_at(time)
        next_chime = time - ::Time.now

        EM.add_timer(next_chime) do
          notify
        end unless next_chime < 0
      end

      def notify
        EM.schedule do
          fire(@time)
        end
      end

      def fire(time)
        if @chime
          @trigger.chiming(time)
        elsif @timeout
          @trigger.timing_out(time)
        end

        if @interval
          @time += @interval
          add_chime_at(@time)
        end
      end
    end
  end
end
