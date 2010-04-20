require 'spec_helper'

describe Xapor::ModelIntegration, "Search integration into a model class" do
  it "should add a xapor function when included" do
    XaporTest.respond_to?(:xapor).should be_false
    XaporTest.send(:include, Xapor::ModelIntegration)
    XaporTest.respond_to?(:xapor).should be_true
  end

  it "should add a search function when xapor is called" do
    XaporTest.send(:include, Xapor::ModelIntegration)
    XaporTest.send(:xapor)
    XaporTest.respond_to?(:search).should be_true
  end

  it "should add a search_by_name function when xapor is called with a block that indexes the name" do
    XaporTest.send(:attr_accessor, :name)
    XaporTest.send(:include, Xapor::ModelIntegration)
    XaporTest.send(:xapor) {|idx| idx.search :name}
    XaporTest.respond_to?(:search_by_name).should be_true
  end
end