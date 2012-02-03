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

  def trigger_timer
    @periodic_block.call
  end
end
