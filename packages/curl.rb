require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  version '7.88.1'
  license 'curl'
  compatibility 'all'
  is_fake

  depends_on 'libcurl'
end
