require 'package'
require_relative 'util_linux'

class Libuuid < Package
  description 'Portable UUID C library. Bundled with util_linux.'
  homepage 'https://sourceforge.net/projects/libuuid/'
  version Util_linux.version.to_s
  license Util_linux.license.to_s
  compatibility Util_linux.compatibility.to_s

  is_fake

  depends_on 'util_linux'
end
