require 'package'
require_relative 'util_linux'

class Libuuid < Package
  description 'Portable UUID C library. Bundled with util_linux.'
  homepage 'https://sourceforge.net/projects/libuuid/'
  version Util_linux.version
  license Util_linux.license
  compatibility Util_linux.compatibility

  is_fake

  depends_on 'util_linux'
end
