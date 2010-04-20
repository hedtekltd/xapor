module Xapor::ModelIntegration
  def self.included(base)
    base.send(:include, Xapor::XapianFuIntegration)
    if defined?(ActiveRecord) && base.is_a?(ActiveRecord::Base)
      base.after_save :add_to_index
    end
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
          xapor_db.search(query)
        end

        def reset_index
          if @db
            @db.flush
            @db.ro.close
            @db.rw.close
          end
          @db = XapianDb.new(@config.xapian_fu_db.merge(:overwrite => true))
          if block_given?
            yield @db
          end
        end

        def xapor_config
          @config
        end

        def xapor_db
          @db ||= XapianDb.new(@config.xapian_fu_db.merge(:create => true))
        end
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

  def add_to_index
    doc = {:id => self.id}
    self.class.xapor_config.search_fields.each do |field|
      doc[field] = self.send(field.to_sym)
    end
    self.class.xapor_db << doc
    self.class.xapor_db.flush
  end
end

if defined? ActiveRecord
  ActiveRecord::Base.class_eval do
    include Xapor::ModelIntegration
  end
end