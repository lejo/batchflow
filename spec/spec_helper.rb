require 'rspec'
require File.join(File.dirname(__FILE__), '..', 'lib', 'batchflow.rb')

EM.instance_eval do
  def add_periodic_timer(i, &block)
    @periodic_block = block
  end

  def schedule
    yield
  end

  def add_timer(i)
    yield
  end

  def defer(block1, block2 = nil)
    block1.call
    block2.call nil if block2
  end

  def trigger_timer
    @periodic_block.call
  end

  module Deferrable
    def callback(&block)
      @callback = block
    end

    def succeed
      @callback.call
    end
  end
end
