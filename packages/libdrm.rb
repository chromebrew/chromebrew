require 'package'

class Libdrm < Package
  description 'Cross-driver middleware for DRI protocol.'
  homepage 'https://dri.freedesktop.org'
  @_ver = '2.4.104'
  version @_ver
  compatibility 'all'
  source_url "https://dri.freedesktop.org/libdrm/libdrm-#{@_ver}.tar.xz"
  source_sha256 'd66ad8b5c2441015ac1333e40137bb803c3bde3612ff040286fcc12158ea1bcb'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libdrm-2.4.104-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libdrm-2.4.104-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/libdrm-2.4.104-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libdrm-2.4.104-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'd92b2cf767f17517a2e90e610749b38d878f126f237bafa027c5f019bd26ab78',
      armv7l: 'd92b2cf767f17517a2e90e610749b38d878f126f237bafa027c5f019bd26ab78',
        i686: 'ffe58ea6bed51afe09957f581c1490643090b8d6b79c6ae0467d0e7d682afa94',
      x86_64: '74ebadab71db82425c8a823e03f9da0f8f44eb692e448c83f8b7d12b69bb76b6',
  })

  depends_on 'libpciaccess'
  depends_on 'xorg_lib'
  depends_on 'eudev'
  depends_on 'libxslt'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
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
