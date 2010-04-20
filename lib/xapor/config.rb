class Xapor::Config
  attr_reader :search_fields
  
  def initialize
    @search_fields = []
  end

  def search(field)
    @search_fields << field
  end
end