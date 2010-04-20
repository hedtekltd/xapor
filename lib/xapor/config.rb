class Xapor::Config
  attr_reader :search_fields
  attr_reader :store_fields
  attr_reader :directory_config
  
  def initialize
    @search_fields = []
    @store_fields = []
  end

  def search(field, options = {})
    @search_fields << field
    if options[:store]
      @store_fields << field
    end
  end

  def directory(path)
    @directory_config = path
  end

  def xapian_fu_db
    db_settings = {}
    db_settings[:dir] = @directory_config if @directory_config
    db_settings[:store] = @store_fields unless @store_fields.empty?
    return db_settings
  end
end