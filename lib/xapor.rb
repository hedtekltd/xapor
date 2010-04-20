require 'rubygems'
require 'delayed_job'
require 'xapian-fu'

module Xapor
  LIB_PATH = File.join(File.dirname(__FILE__), "xapor")
end

require File.join(Xapor::LIB_PATH, "model_integration")
require File.join(Xapor::LIB_PATH, "config")