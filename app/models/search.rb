class Search < ApplicationRecord
  validates :query, length: {minimum: 3}
  validates :ip, presence: true

  scope :by_ip, ->(ip) { where(ip: ip) }

  def contained_in_existing_search?
    existing_ip_queries = Search.by_ip(ip)
    existing_ip_queries.each do |existing_ip_query|
      return true if existing_ip_query.query.include?(query)
    end
    false
  end

  def remove_contained_searches
    existing_ip_searches = Search.by_ip(ip)
    remove_contains(existing_ip_searches)
  end

  def remove_contains(existing_ip_searches)
    existing_ip_searches.each do |existing_ip_query|
      existing_ip_query.destroy if query.include?(existing_ip_query.query)
    end
  end
end