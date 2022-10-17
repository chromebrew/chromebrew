require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  version '7.85.0'
  license 'curl'
  compatibility 'all'
  is_fake

  depends_on 'libcurl'
end
