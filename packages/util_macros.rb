require 'buildsystems/autotools/v1'

class Util_macros < Autotools_v1
  description 'The util-macros package contains the m4 macros used by all of the Xorg packages'
  homepage 'https://www.linuxfromscratch.org/blfs/view/svn/util-macros.html'
  @_ver = '1.19.3'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url "https://xorg.freedesktop.org/releases/individual/util/util-macros-#{@_ver}.tar.bz2"
  source_sha256 '0f812e6e9d2786ba8f54b960ee563c0663ddbe2434bf24ff193f5feab1f31971'
end
