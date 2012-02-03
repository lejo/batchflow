$:.unshift(File.join(File.dirname(__FILE__), '..'))
$:.unshift(File.join(File.dirname(__FILE__), 'batchflow'))

require 'eventmachine'

require 'version'
require 'dsl'
require 'job_repository'
require 'core/engine'
require 'core/job'
require 'core/task'
require 'core/trigger'
require 'core/file_watcher'
require 'core/time_watcher'

Dir.glob(File.join(File.dirname(__FILE__), 'batchflow', 'payloads', '**/*.rb')) do |file|
  require file
end
