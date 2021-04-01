require 'package'

class Libuuid < Package
  description 'Portable UUID C library'
  homepage 'https://sourceforge.net/projects/libuuid/'
  version '1.3.0'
  license 'BSD' # The actual libuuid library
  compatibility 'all'

  is_fake

  depends_on 'util_linux'
end
