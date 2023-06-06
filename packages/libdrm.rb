require 'package'

class Libdrm < Package
  description 'Cross-driver middleware for DRI protocol.'
  homepage 'https://dri.freedesktop.org'
  @_ver = '2.4.114'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/mesa/drm.git'
  git_hashtag "libdrm-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdrm/2.4.114_armv7l/libdrm-2.4.114-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdrm/2.4.114_armv7l/libdrm-2.4.114-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdrm/2.4.114_i686/libdrm-2.4.114-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdrm/2.4.114_x86_64/libdrm-2.4.114-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '22204bf614205ee547091bea152cfa7a94f623ba87bf9e2b549b5e4177fd9d8c',
     armv7l: '22204bf614205ee547091bea152cfa7a94f623ba87bf9e2b549b5e4177fd9d8c',
       i686: '154326bf8f1d4d42c87550580a8295f490807e463ef74ff9f56d36a64efc358e',
     x86_64: 'd22e18ca912b0ec5ce698a03eec86f45ded30c55a04265c975468328ef3204ef'
  })

  depends_on 'cairo' # R
  depends_on 'libpciaccess' # R
  depends_on 'eudev' => :build
  depends_on 'libxslt' => :build
  depends_on 'glibc' # R
  depends_on 'gcc_lib' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      -Dfreedreno-kgsl=true \
      -Damdgpu=enabled \
      -Dradeon=enabled \
      -Dnouveau=enabled \
      -Dintel=auto \
      -Dvmwgfx=enabled \
      -Dvc4=auto \
      -Dfreedreno=enabled \
      -Detnaviv=auto \
      -Dexynos=auto \
      -Dtests=false \
      -Dudev=true \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
