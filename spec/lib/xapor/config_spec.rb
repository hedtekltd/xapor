require 'spec_helper'

describe Xapor::Config, "Configuration settings for a Xapor index" do
  it "should allow specification of search fields" do
    config = Xapor::Config.new
    config.respond_to?(:search).should be_true
    config.search :test
    config.search_fields.should == [:test]
  end
end