require 'package'

class Libva < Package
  description 'Libva is an implementation for VA-API (Video Acceleration API)'
  homepage 'https://01.org/linuxmedia'
  @_ver = '2.16.0'
  version @_ver.to_s
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/intel/libva.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'file:///usr/local/tmp/packages/libva-2.16.0-chromeos-armv7l.tar.zst',
     armv7l: 'file:///usr/local/tmp/packages/libva-2.16.0-chromeos-armv7l.tar.zst',
       i686: 'file:///usr/local/tmp/packages/libva-2.16.0-chromeos-i686.tar.zst',
     x86_64: 'file:///usr/local/tmp/packages/libva-2.16.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ac2a55f303a50fc14f80f0308cdef28cee672d08a435e806b27f4845b4a16402',
     armv7l: 'ac2a55f303a50fc14f80f0308cdef28cee672d08a435e806b27f4845b4a16402',
       i686: '080be345a0938b687dea51acae964e89f3b5b34169283a6bd6a9f55d9b839356',
     x86_64: '320022e94dc9beac537279085f66d4caa270e8af9fe4eb0455fbaa11b48c5258'
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
