module Xapor::ModelIntegration

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def xapor
      class << self
        def search(query)
          []
        end
      end
      config = Xapor::Config.new
      if block_given?
        yield config
      end
      config.search_fields.each do |field|
        class_eval("def self.search_by_#{field}\nend")
      end
    end
  end
end