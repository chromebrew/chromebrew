require 'package'

class Libinih < Package
  description 'A simple .INI file parser written in C'
  homepage 'https://github.com/benhoyt/inih'
  version 'r56'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/benhoyt/inih/archive/r56.tar.gz'
  source_sha256 '4f2ba6bd122d30281a8c7a4d5723b7af90b56aa828c0e88256d7fceda03a491a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libinih/r56_armv7l/libinih-r56-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libinih/r56_armv7l/libinih-r56-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libinih/r56_i686/libinih-r56-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libinih/r56_x86_64/libinih-r56-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '343920e4395e4796ac4b59476808427c9a967490f8693c9be68a02706c3591d2',
     armv7l: '343920e4395e4796ac4b59476808427c9a967490f8693c9be68a02706c3591d2',
       i686: '55670d4dd11e48e1e4728596ceec33cc6d25fe4ec371cdfd2e2ef53cd483401a',
     x86_64: '04d8b95f7242efe441d26b228e7481af59768cfdef9211cb0a74792b97b91511'
  })

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      -Ddefault_library=both \
      -Ddistro_install=true \
      -Dwith_INIReader=true \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
