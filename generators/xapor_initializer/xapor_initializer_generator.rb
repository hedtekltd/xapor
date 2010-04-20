class XaporInitializerGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.directory 'config/initializers'
      m.template 'xapor.rb', 'config/initializers/xapor.rb'
    end
  end
end