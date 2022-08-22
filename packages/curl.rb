require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  @_ver = '7.82.0'
  version @_ver
  license 'curl'
  compatibility 'all'
  is_fake

  depends_on 'libcurl'
end
