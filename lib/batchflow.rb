$:.unshift(File.join(File.dirname(__FILE__), 'batchflow'))

require 'version'
require 'dsl'
require 'job_repository'
require 'core/job'
require 'core/task'
require 'core/trigger'
