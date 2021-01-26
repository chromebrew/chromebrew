require 'package'

class Libinih < Package
  description 'A simple .INI file parser written in C'
  homepage 'https://github.com/benhoyt/inih'
  @_ver = '52'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/benhoyt/inih/archive/r#{@_ver}.tar.gz"
  source_sha256 '439cff9ce9a8afc52d08772ac3e93b3cecd79c7707f871fb4534fb3a48201880'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libinih-52-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libinih-52-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/libinih-52-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libinih-52-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '813f8831babc7ab96bc4ec618b3b702e09906c97f7d319dc24e7cb5cf9b517a9',
      armv7l: '813f8831babc7ab96bc4ec618b3b702e09906c97f7d319dc24e7cb5cf9b517a9',
        i686: '652b3f23a2e720dcc915894a8c335efa08b664782c667331e7fea40f41debfb6',
      x86_64: '81bc105c7144a03bb7a81a5997925fa67973c62c8598730586942950d40098b4',
  })

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Ddefault_library=both \
    -Ddistro_install=true \
    -Dwith_INIReader=true \
    builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
