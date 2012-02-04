$:.unshift(File.join(File.dirname(__FILE__), 'core'))

require 'core/dsl'
require 'core/job_repository'
require 'core/engine'
require 'core/job'
require 'core/task'
