require 'package'

class Libva < Package
  description 'Libva is an implementation for VA-API (Video Acceleration API)'
  homepage 'https://01.org/linuxmedia'
  @_ver = '2.14.0'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/intel/libva.git'
  git_hashtag @_ver

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libva/2.14.0-1_i686/libva-2.14.0-1-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libva/2.14.0-1_x86_64/libva-2.14.0-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: '1700a56897fe819b81ea1f9eab16a440c29176bea367d502438baa5b17c44b18',
  x86_64: '308c44dc90c0dd695865aab25f3054af5bcdc6845202e079262d4e70b1aca1d9'
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
