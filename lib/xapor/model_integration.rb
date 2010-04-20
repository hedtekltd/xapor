module Xapor::ModelIntegration
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def xapor
      class << self
        include XapianFu
        
        def search(query)
          db = XapianDb.new(@@config.xapian_fu_db)
          db.search(query)
        end
      end
      @@config = Xapor::Config.new
      if block_given?
        yield @@config
      end
      @@config.search_fields.each do |field|
        class_eval("def self.search_by_#{field}(query)\nself.search(query)\nend")
      end
    end
  end
end