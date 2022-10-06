require 'package'

class Libdrm < Package
  description 'Cross-driver middleware for DRI protocol.'
  homepage 'https://dri.freedesktop.org'
  @_ver = '2.4.113'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/mesa/drm.git'
  git_hashtag "libdrm-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdrm/2.4.113_armv7l/libdrm-2.4.113-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdrm/2.4.113_armv7l/libdrm-2.4.113-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdrm/2.4.113_i686/libdrm-2.4.113-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdrm/2.4.113_x86_64/libdrm-2.4.113-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd89807cb6e368b1bb03f8351a3c699463fe81cb0533fc2d54ec0d917f41974c8',
     armv7l: 'd89807cb6e368b1bb03f8351a3c699463fe81cb0533fc2d54ec0d917f41974c8',
       i686: '41e96c881ac6e9dd40b500095d1e8bc060477cb5c6b2662661ae5d4797fc78cc',
     x86_64: '950a8cbf4110cc3b9e10127aa09be07e8d9828e115d6eb4ec18ec23d81818f77'
  })

  depends_on 'libpciaccess' # R
  depends_on 'xorg_lib' => :build
  depends_on 'eudev' => :build
  depends_on 'libxslt' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
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
