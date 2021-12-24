require 'package'

class Xorg_proto < Package
  description 'The xorgproto package provides the header files required to build the X Window system, and to allow other applications to build against the installed X Window system.'
  homepage 'https://www.x.org/'
  version '2021.5'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/proto/xorgproto.git'
  git_hashtag "xorgproto-#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_proto/2021.5_armv7l/xorg_proto-2021.5-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_proto/2021.5_armv7l/xorg_proto-2021.5-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_proto/2021.5_i686/xorg_proto-2021.5-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_proto/2021.5_x86_64/xorg_proto-2021.5-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '1bc453ccee0bc6e0e4709502c09b0e6c86d72c50d9e1b16e00799e7ee7ab2e3d',
     armv7l: '1bc453ccee0bc6e0e4709502c09b0e6c86d72c50d9e1b16e00799e7ee7ab2e3d',
       i686: 'ddca69d7d028a8696f175ecae67dcff30e3139cc664b24b7977a20f482acb280',
     x86_64: '20dd21738b3e2c1521f34a6993071ff797f99d81e4b5c154c560e9cf2f6062a8'
  })

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
