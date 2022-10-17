require 'buildsystems/autotools/v1'

class Mawk < Autotools_v1
  description 'mawk is a POSIX compatible interpreter of the awk language faster than gawk.'
  homepage 'https://invisible-island.net/mawk/'
  @_ver = '1.3.4.20200120'
  @_debver = '3.1'
  version "#{@_ver}-#{@_debver}"
  license 'GPL-2'
  compatibility 'all'
  source_url "https://salsa.debian.org/debian/mawk/-/archive/debian/#{@_ver}-#{@_debver}/mawk-debian-#{@_ver}-#{@_debver}.tar.bz2"
  source_sha256 '007f79fc63bb6e6098c475a51073e61e4cedf675784768aedac5eaa5887efdfe'

  depends_on 'glibc' # R
  depends_on 'groff' => :build
end
