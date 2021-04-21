require 'package'

class Valgrind < Package
  description 'Valgrind is an instrumentation framework for building dynamic analysis tools.'
  homepage 'https://valgrind.org/'
  version '3.17'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://sourceware.org/pub/valgrind/valgrind-3.17.0.tar.bz2'
  source_sha256 'ad3aec668e813e40f238995f60796d9590eee64a16dff88421430630e69285a2'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/valgrind-3.13.0-3-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/valgrind-3.13.0-3-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/valgrind-3.13.0-3-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/valgrind-3.13.0-3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '7ed434448c96b37fae3ddc546f3950fc705892179522b16d0210292ecad9d1a4',
     armv7l: '7ed434448c96b37fae3ddc546f3950fc705892179522b16d0210292ecad9d1a4',
       i686: 'e332c6d0447e71c54712359d90ae986ddff253a0b2c059d882810d6159766abe',
     x86_64: 'c468df7dad7a385b6759833b0939f2551804dde400bb3b2629315c8ee80c8b45'
  })

  def self.build
    system 'autoreconf -fvi'
    system "env #{CREW_ENV_OPTIONS}
      RANLIB=gcc-ranlib \
      AR=gcc-ar \
      ./configure #{CREW_OPTIONS} \
       --enable-lto"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
