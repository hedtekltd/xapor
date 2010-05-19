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
        attr_accessor :xapor_config
        attr_accessor :xapor_db
      end
      
      include XapianFu

      def self.search(query)
        xapor_db.search(query)
      end

      def self.reset_index
        if @db
          @db.flush
          @db.ro.close
          @db.rw.close
        end
        @db = XapianDb.new(xapor_config.xapian_fu_db.merge(:overwrite => true))
        if block_given?
          yield @db
        end
      end

      self.xapor_config = Xapor::Config.new
      if block_given?
        yield self.xapor_config
      end
      self.xapor_db = ::XapianFu::XapianDb.new(self.xapor_config.xapian_fu_db.merge(:create => true))

      eigenclass = class << self
        self
      end
      self.xapor_config.search_fields.each do |field|
          eigenclass.send(:define_method, :"search_by_#{field}") do |query|
            self.search(query)
          end
        end

      if defined? ActiveRecord && ancestors.includes(ActiveRecord::Base)
        after_save :add_to_index
        after_destroy :remove_from_index
        #in-memory index, needs to be indexed on startup
        all.each {|o| o.add_to_index} unless self.xapor_config.directory_config
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

  def remove_from_index
    self.class.xapor_db.documents.delete(self.id)
    self.class.xapor_db.flush
  end
end

if defined? ActiveRecord
  ActiveRecord::Base.class_eval do
    include Xapor::ModelIntegration
  end
end