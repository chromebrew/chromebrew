require 'package'
require_relative 'curl'

class Libcurl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  version Curl.version.to_s
  license 'curl'
  compatibility 'all'
  is_fake

  depends_on 'curl'

  def self.postinstall
    system 'crew reinstall curl' unless File.file?("#{CREW_PREFIX}/bin/curl")
  end
end
