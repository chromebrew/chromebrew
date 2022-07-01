require 'package'

class Libva < Package
  description 'Libva is an implementation for VA-API (Video Acceleration API)'
  homepage 'https://01.org/linuxmedia'
  @_ver = '2.15.0'
  version @_ver.to_s
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/intel/libva.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libva/2.15.0_armv7l/libva-2.15.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libva/2.15.0_armv7l/libva-2.15.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libva/2.15.0_i686/libva-2.15.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libva/2.15.0_x86_64/libva-2.15.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '201b781e9ecae81f6d7b978f9314ca321f6dbe78829467f84f5f38461597b371',
     armv7l: '201b781e9ecae81f6d7b978f9314ca321f6dbe78829467f84f5f38461597b371',
       i686: 'db83ae08bb404bfec867ba159a30b1d9bca57d4fe17f22332965da0ce4aab8da',
     x86_64: '660fde88cdf68687ae52aca11d88ecc90424a943d7dd16ab5c572143637007a4'
  })

  depends_on 'libdrm'
  depends_on 'libx11'
  depends_on 'libxext'
  depends_on 'libxfixes'
  depends_on 'mesa'
  depends_on 'wayland'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    --default-library=both \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.check
    system 'ninja -C builddir test'
  end
end
