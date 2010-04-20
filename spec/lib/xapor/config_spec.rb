require 'spec_helper'

describe Xapor::Config, "Configuration settings for a Xapor index" do
  it "should allow specification of search fields" do
    config = Xapor::Config.new
    config.respond_to?(:search).should be_true
    config.search :test
    config.search_fields.should == [:test]
  end

  it "should allow specification of the index location" do
    config = Xapor::Config.new
    config.respond_to?(:directory).should be_true
    config.directory "test/path.db"
    config.directory_config.should == "test/path.db"
  end

  it "should let you specify if you want to store a field" do
    config = Xapor::Config.new
    config.search :test, :store => true
    config.store_fields.should == [:test]
  end

  it "should provide XapianFu config settings" do
    config = Xapor::Config.new
    config.directory "test/path.db"
    config.xapian_fu_db.should == {:dir => "test/path.db"}
  end
end