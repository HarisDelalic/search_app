class Searcher
  attr_reader :search
  def initialize(search, ip, search_params)
    @search = search
    @ip = ip
    @search_params = search_params
  end

  def run
    Search.transaction do
      search.assign_attributes(@search_params)
      search.ip = @ip
      search.remove_contained_searches
      search.save unless search.contained_by_existing_search?
    end
  end

  def ip_params
    { 'ip' => @ip }
  end
end