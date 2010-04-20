module Xapor::ModelIntegration
  def self.included(base)
    base.send(:include, Xapor::XapianFuIntegration)
  end
end

module Xapor::XapianFuIntegration
  include XapianFu
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def xapor
      class << self
        include XapianFu

        def search(query)
          db = XapianDb.new(@config.xapian_fu_db)
          db.search(query)
        end

        def xapor_config
          @config
        end
      end
      if self.ancestors.include?(ActiveRecord::Base)
        after_save :add_to_index
      end
      @config = Xapor::Config.new
      if block_given?
        yield @config
      end
      @config.search_fields.each do |field|
        class_eval("def self.search_by_#{field}(query)\nself.search(query)\nend")
      end
    end
  end

  def perform
    config = self.class.xapor_config
    db = XapianDb.new(config.xapian_fu_db.merge(:create => true))
    doc = {:id => self.id}
    config.search_fields.each do |field|
      doc[field] = self.send(field.to_sym)
    end
    db << doc
    db.flush
  end

  def add_to_index
    Delayed::Job.enqueue self
  end
end

if defined? ActiveRecord
  ActiveRecord::Base.class_eval do
    include Xapor::ModelIntegration
  end
end