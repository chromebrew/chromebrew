require 'buildsystems/meson'

class Xorg_proto < Meson
  description 'The xorgproto package provides the header files required to build the X Window system, and to allow other applications to build against the installed X Window system.'
  homepage 'https://www.x.org/wiki/'
  version '2025.1'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/proto/xorgproto.git'
  git_hashtag "xorgproto-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1d6ba51b9c0a20f8a661708a1d535cb362efc3e97a46d9ea0ed080bb1a40a7c9',
     armv7l: '1d6ba51b9c0a20f8a661708a1d535cb362efc3e97a46d9ea0ed080bb1a40a7c9',
     x86_64: 'c9a68de6a297a2225059c7bbfe67d88757c958f668b06fdabce46da0ad4860d8'
  })

  # This is needed to provide the deprecated printproto specifications required to build libxp, which is itself deprecated.
  meson_options '-Dlegacy=true'

  def self.postbuild
    # Remove file that is included with libx11.
    FileUtils.rm "#{CREW_DEST_PREFIX}/include/X11/extensions/XKBgeom.h"
  end
end
