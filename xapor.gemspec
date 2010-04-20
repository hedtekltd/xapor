# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{xapor}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["David Workman"]
  s.date = %q{2010-04-20}
  s.description = %q{Rails plugin for Xapian search, built on XapianFu and DelayedJob.}
  s.email = %q{workmad3@hedtek.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "features/step_definitions/xapor_steps.rb",
     "features/support/env.rb",
     "features/xapor.feature",
     "init.rb",
     "lib/xapor.rb",
     "lib/xapor/config.rb",
     "lib/xapor/model_integration.rb",
     "spec/lib/xapor/config_spec.rb",
     "spec/lib/xapor/model_integration_spec.rb",
     "spec/lib/xapor_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/hedtekltd/xapor}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Rails plugin for Xapian search}
  s.test_files = [
    "spec/lib/xapor/config_spec.rb",
     "spec/lib/xapor/model_integration_spec.rb",
     "spec/lib/xapor_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<xapian-fu>, [">= 1.1.0"])
      s.add_runtime_dependency(%q<delayed_job>, [">= 2.0.3"])
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_development_dependency(%q<cucumber>, [">= 0"])
    else
      s.add_dependency(%q<xapian-fu>, [">= 1.1.0"])
      s.add_dependency(%q<delayed_job>, [">= 2.0.3"])
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<cucumber>, [">= 0"])
    end
  else
    s.add_dependency(%q<xapian-fu>, [">= 1.1.0"])
    s.add_dependency(%q<delayed_job>, [">= 2.0.3"])
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<cucumber>, [">= 0"])
  end
end

