$:.unshift(File.join(File.dirname(__FILE__), '..'))
$:.unshift(File.join(File.dirname(__FILE__), 'batchflow'))

require 'eventmachine'

require 'version'
require 'dsl'
require 'job_repository'
require 'support/hash_initializer'
require 'core/engine'
require 'core/job'
require 'core/task'
require 'core/trigger'
require 'core/file_trigger'
require 'core/timer_trigger'
require 'core/task_trigger'
require 'core/file_watcher'
require 'core/time_watcher'

Dir.glob(File.join(File.dirname(__FILE__), '..', 'payloads', '**/*.rb')) do |file|
  require file
end
