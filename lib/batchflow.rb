$:.unshift(File.join(File.dirname(__FILE__), '..'))
$:.unshift(File.join(File.dirname(__FILE__), 'batchflow'))

require 'eventmachine'

require 'version'
require 'support'
require 'watchers'
require 'triggers'
require 'trigger'
require 'core'

Dir.glob(File.join(File.dirname(__FILE__), '..', 'payloads', '**/*.rb')) do |file|
  require file
end
