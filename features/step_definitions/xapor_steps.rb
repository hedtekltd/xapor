class XaporTest

end

Given /^I have a model object with "([^\"]*)"$/ do |field|
  XaporTest.send(:attr_accessor, field.to_sym)
  XaporTest.new.respond_to?(field.to_sym).should be_true
  XaporTest.new.respond_to?(:"#{field}=").should be_true
end

When /^I call xapor to index "([^\"]*)"$/ do |field|
  XaporTest.send(:include, Xapor::ModelIntegration)
  XaporTest.send(:xapor) do |index|
    index.search field.to_sym
  end
end

Then /^I should have a "([^\"]*)" function$/ do |func_name|
  @test = XaporTest.new
  @test.respond_to?(func_name.to_sym).should be_true
end

Then /^I should have a "([^\"]*)" class function$/ do |func_name|
  XaporTest.respond_to?(func_name.to_sym).should be_true
end

Given /^I have a xapor model object with a name$/ do
  XaporTest.send(:attr_accessor, :name)
  XaporTest.send(:include, Xapor::ModelIntegration)
  XaporTest.send(:xapor) do |index|
    index.search :name
  end
end

When /^I have a xapor model with name "([^\"]*)"$/ do |name|
  model = XaporTest.new
  model.name = name
  if !@models
    @models = []
  end
  @models << model
end
When /^I search the model for "([^\"]*)"$/ do |query|
  @search_results = XaporTest.search(query)
end
Then /^I should get 1 result$/ do
  @search_results.size.should == 1
end