$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'xapor'
require 'spec'
require 'spec/autorun'

Spec::Runner.configure do |config|
  
end

# An empty class to be used for hooking on the Xapor spec functionality
class XaporTest

end