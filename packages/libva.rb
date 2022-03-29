require 'package'

class Libva < Package
  description 'Libva is an implementation for VA-API (Video Acceleration API)'
  homepage 'https://01.org/linuxmedia'
  @_ver = '2.14.0'
  version "#{@_ver}-2"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/intel/libva.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libva/2.14.0-2_armv7l/libva-2.14.0-2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libva/2.14.0-2_armv7l/libva-2.14.0-2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libva/2.14.0-2_i686/libva-2.14.0-2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libva/2.14.0-2_x86_64/libva-2.14.0-2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fccd32adece0312102e7294dc451ca4c8abb267abaf4726470da491891423101',
     armv7l: 'fccd32adece0312102e7294dc451ca4c8abb267abaf4726470da491891423101',
       i686: '98c2d3379fe1b513f4c1f8edfdc7424e84d940408141d63a065c29a92503e162',
     x86_64: '7baea1dbbeb4fac85e384403151c0b8baefb366c8d7c982bac63c6ef15990fde'
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

  def self.check
    system 'ninja -C builddir test'
  end
end
