class SearchesController < ApplicationController
  def index
    @search = Search.new
    @searches = Search.all
  end

  def create
    @search = Search.new(search_params)
    @search.remove_contained_searches
    unless @search.contained_by_existing_search?
      @search.save
    end
  end

  private
  def search_params
    params.require(:search).permit(:ip, :query)
  end
end