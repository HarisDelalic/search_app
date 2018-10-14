class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def remote_ip
    forwarded_ips.first || request.remote_ip
  end

  def forwarded_ips
    @forwarded_ips ||= fetch_forwarded_ips
  end

  def fetch_forwarded_ips
    return [] if request.env['HTTP_X_FORWARDED_FOR'].blank?
    request.env['HTTP_X_FORWARDED_FOR'].split(',').map(&:strip)
  end
end
