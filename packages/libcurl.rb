require 'package'
require_relative 'curl'

class Libcurl < Package
  description Curl.description.to_s
  homepage Curl.homepage.to_s
  version Curl.version.to_s
  license Curl.license.to_s
  compatibility Curl.compatibility.to_s

  is_fake

  depends_on 'curl'

  def self.postinstall
    system 'crew reinstall curl' unless File.file?("#{CREW_PREFIX}/bin/curl")
  end
end
