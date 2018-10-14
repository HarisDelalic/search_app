class SearchesController < ApplicationController
  def index
    @search = Search.new
    @searches = Search.all
  end

  def create
    @search = Search.new(search_params)
    Searcher.new(@search, remote_ip, search_params).run
    redirect_to searches_path
  end

  private
  def search_params
    params.require(:search).permit(:query)
  end
end