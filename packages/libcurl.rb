require 'package'
require_relative 'curl'

class Libcurl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  @curlversion = Curl.version
  version @curlversion
  license 'curl'
  compatibility 'all'
  is_fake

  depends_on 'curl'
end
