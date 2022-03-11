require 'package'

class Libva < Package
  description 'Libva is an implementation for VA-API (Video Acceleration API)'
  homepage 'https://01.org/linuxmedia'
  @_ver = '2.14.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/intel/libva.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libva/2.14.0_armv7l/libva-2.14.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libva/2.14.0_armv7l/libva-2.14.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libva/2.14.0_i686/libva-2.14.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libva/2.14.0_x86_64/libva-2.14.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1177ea4f0e3d8218a917070ba4943a8850ffb48c92be88c53373a77c35063c08',
     armv7l: '1177ea4f0e3d8218a917070ba4943a8850ffb48c92be88c53373a77c35063c08',
       i686: 'e77eafe870dde013f5868eabebdd1ea0980ae642c28b11d5d4ee8b8f60c0fbfe',
     x86_64: '4f330f77b5cdec5d11bcce6436c601db00c3def6fe07ebaaebd163068eb566ed'
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
