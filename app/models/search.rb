class Search < ApplicationRecord
  validates :query, length: {minimum: 3}
  validates :ip, presence: true

  scope :by_ip, ->(ip) { where(ip: ip) }

  def contained_in_existing_search?
    return false if without_ip
    existing_ip_queries = Search.by_ip(ip)
    existing_ip_queries.each do |existing_ip_query|
      return true if existing_ip_query.query.include?(query)
    end
    false
  end

  def remove_contained_searches
    return false if without_ip
    existing_ip_searches = Search.by_ip(ip)
    remove_contains(existing_ip_searches)
  end

  private
  def remove_contains(existing_ip_searches)
    existing_ip_searches.each do |existing_ip_query|
      existing_ip_query.destroy if query.include?(existing_ip_query.query)
    end
  end

  def without_ip
    ip.nil?
  end
end