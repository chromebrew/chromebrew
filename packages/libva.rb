require 'package'

class Libva < Package
  description 'Libva is an implementation for VA-API (Video Acceleration API)'
  homepage 'https://01.org/linuxmedia'
  @_ver = '2.12.0'
  version @_ver
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/intel/libva.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libva/2.12.0_armv7l/libva-2.12.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libva/2.12.0_armv7l/libva-2.12.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libva/2.12.0_x86_64/libva-2.12.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'e64a354e9607f5b220a22d33ebe24cf8b933a0cd97bad7efa0376fdd8ef27c52',
     armv7l: 'e64a354e9607f5b220a22d33ebe24cf8b933a0cd97bad7efa0376fdd8ef27c52',
     x86_64: '7cdc4741dd68458cdff0fff55ef4600af6fcf3b0fc385acc5649eda4bfcea0be'
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
    -Db_lto=true \
    -Db_pie=true \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
