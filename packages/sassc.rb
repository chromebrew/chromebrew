require 'package'

class Sassc < Package
  description 'C implementation of Sass CSS preprocessor.'
  version '3.6.1-66f0'
  compatibility 'all'
  source_url 'https://github.com/sass/sassc/archive/66f0ef37e7f0ad3a65d2f481eff09d09408f42d0.zip'
  source_sha256 'a2077ae439f29c45ce76c81b9b4e63aed1b7f41e9f5fc82881c2d52752c6f440'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sassc-3.6.1-66f0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sassc-3.6.1-66f0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sassc-3.6.1-66f0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sassc-3.6.1-66f0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'e0beec78444eca58f93f7a874ee660bf07aa67610609a8a615474f0e4be606aa',
     armv7l: 'e0beec78444eca58f93f7a874ee660bf07aa67610609a8a615474f0e4be606aa',
       i686: '03053905322947680cbe1f4941434beb39217ece66ccf670729338ea853d47b6',
     x86_64: '052467d9f5395e41cd73c715a3b3852ce1c45b14e219a5726781a4bdab433fb4'
  })

  depends_on 'libsass'

  def self.build
    system 'autoreconf -i'
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
