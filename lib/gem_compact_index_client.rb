require 'uri'
require_relative 'downloader'

# Adapted from https://github.com/rubygems/rubygems/issues/8012#issuecomment-2375499571
# by @duckinator (Ellen Marie Dash)
# A very bare-bones client for the Compact Index API
# https://guides.rubygems.org/rubygems-org-compact-index-api/

class BasicCompactIndexClient
  def initialize(gem_server = 'https://rubygems.org/')
    @gem_server = gem_server
  end

  # Returns a list of all gems on the specified gem server.
  def gems
    lines(request('/versions'))
  end

  private

  def request(endpoint)
    uri      = URI.join(@gem_server, endpoint)
    response = get_http_response(uri)

    raise "got HTTP code #{response.code}, expected 200" unless response.is_a?(Net::HTTPOK)

    return response.body
  end

  def lines(data)
    return [] if data.nil? || data.empty?
    lines = data.split("\n")
    header = lines.index('---')
    header ? lines[(header + 1)..] : lines
  end
end
