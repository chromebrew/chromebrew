require 'buildsystems/meson'

class Xorg_proto < Meson
  description 'The xorgproto package provides the header files required to build the X Window system, and to allow other applications to build against the installed X Window system.'
  homepage 'https://www.x.org/wiki/'
  version '2026.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/proto/xorgproto.git'
  git_hashtag "xorgproto-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c95eec05bf4f04bf2b9446cc2de1bad4d6b8d7e413a55c8bb2473f2631f68981',
     armv7l: 'c95eec05bf4f04bf2b9446cc2de1bad4d6b8d7e413a55c8bb2473f2631f68981',
       i686: 'bce1904f1280bb37154c3cb039925887dde41ff3f8e9aeb47a14e74bf85cfea8',
     x86_64: 'd45e1eb41187eba9ec78e791ea80f8f12cba772793e328870ecdf3df3c4620d2'
  })

  # This is needed to provide the deprecated printproto specifications required to build libxp, which is itself deprecated.
  meson_options '-Dlegacy=true'

  def self.postbuild
    # Remove file that is included with libx11.
    FileUtils.rm "#{CREW_DEST_PREFIX}/include/X11/extensions/XKBgeom.h"
  end
end
