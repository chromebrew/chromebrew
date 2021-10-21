require 'package'

class Libdrm < Package
  description 'Cross-driver middleware for DRI protocol.'
  homepage 'https://dri.freedesktop.org'
  @_ver = '2.4.107'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url "https://dri.freedesktop.org/libdrm/libdrm-#{@_ver}.tar.xz"
  source_sha256 'c554cef03b033636a975543eab363cc19081cb464595d3da1ec129f87370f888'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdrm/2.4.107_armv7l/libdrm-2.4.107-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdrm/2.4.107_armv7l/libdrm-2.4.107-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdrm/2.4.107_i686/libdrm-2.4.107-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdrm/2.4.107_x86_64/libdrm-2.4.107-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '7610b79d04ea3bd1a74a56fc947fd226bf902d8ff4ca41f62ee61acf95982bcd',
     armv7l: '7610b79d04ea3bd1a74a56fc947fd226bf902d8ff4ca41f62ee61acf95982bcd',
       i686: 'f58054bfde2dc616ca703633275940d6d211020fd3719db0a6acdbb4ae38b203',
     x86_64: 'acad6807fb51761065d53d118f5b6676a9f643af18f87e6ad6dd68c15a734fbe'
  })

  depends_on 'libpciaccess' # R
  depends_on 'xorg_lib' => :build
  depends_on 'eudev' => :build
  depends_on 'libxslt' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      -Dfreedreno-kgsl=true \
      -Damdgpu=true \
      -Dradeon=true \
      -Dnouveau=true \
      -Dintel=true \
      -Dvmwgfx=true \
      -Dvc4=true \
      -Dfreedreno=true \
      -Detnaviv=true \
      -Dlibkms=true \
      -Dexynos=true \
      -Dudev=true \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
