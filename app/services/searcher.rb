class Searcher
  attr_reader :search, :ip, :search_params
  def initialize(search, ip, search_params)
    @search = search
    @ip = ip
    @search_params = search_params
  end

  # if new search is substring of existing search, like user searches "change"
  # but there is already search from same ip to string "change money", in that case
  # nothing is done in database.
  # Other case: user searches "change money", but in database we have entry "change",
  # again from same IP, in that case search with query "change" should be deleted, and
  # search with query "change money persisted"
  def run
    Search.transaction do
      search.assign_attributes(search_params)
      search.ip = ip
      unless search.contained_in_existing_search?
        search.remove_contained_searches
        search.save
      end
    end
  end
end