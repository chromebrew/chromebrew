require 'package'

class Bz2 < Package
  description 'bzip2 is a freely available, patent free, high-quality data compressor.'
  homepage 'http://www.bzip.org/'
  version '1.0.6-2'
  source_url 'https://fossies.org/linux/misc/bzip2-1.0.6.tar.xz'
  source_sha256 '4bbea71ae30a0e5a8ddcee8da750bc978a479ba11e04498d082fa65c2f8c1ad5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bz2-1.0.6-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bz2-1.0.6-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bz2-1.0.6-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bz2-1.0.6-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c46ed5a6a89650f945fd627caad1778ee8a6c14abf98e1c7c1497c634210ab0c',
     armv7l: 'c46ed5a6a89650f945fd627caad1778ee8a6c14abf98e1c7c1497c634210ab0c',
       i686: 'e014d6cf82a39221aa5657244dc2b8af6a693c77fbfacd0653c01eb8fd393514',
     x86_64: '03750d307fca3c0ea2829ba357196373630400299fd519da6963f266cd10a091',
  })

  def self.build
    system "make -f Makefile-libbz2_so"
  end

  def self.install
    # bz2 Makefile doesn't have DESTDIR, so we need several tricks
    # to make it install files correctly.

    # Modify Makefile from "ln -s $(PREFIX)/bin/xxx $(PREFIX)/bin/yyy" to
    # "ln -s xxx $(PREFIX)/bin/yyy"
    system "sed -i Makefile -e '/ln -s/s:$(PREFIX)/bin/::'"

    # Use PREFIX instead of DESTDIR
    system "make", "PREFIX=#{CREW_DEST_PREFIX}", "install"

    # Remove static library
    system "rm #{CREW_DEST_PREFIX}/lib/libbz2.a"

    # Install bzip2 using shared library by hand
    system "cp -p bzip2-shared bzip2"
    system "install -Dm755 bzip2 #{CREW_DEST_PREFIX}/bin/bzip2"
    system "ln -sf bzip2 #{CREW_DEST_PREFIX}/bin/bunzip2"
    system "ln -sf bzip2 #{CREW_DEST_PREFIX}/bin/bzcat"

    # Install shared library by hand
    system "install -Dm644 libbz2.so.1.0.6 #{CREW_DEST_LIB_PREFIX}/libbz2.so.1.0.6"
    system "ln -s libbz2.so.1.0.6 #{CREW_DEST_LIB_PREFIX}/libbz2.so.1.0"
    system "ln -s libbz2.so.1.0.6 #{CREW_DEST_LIB_PREFIX}/libbz2.so.1"
    system "ln -s libbz2.so.1.0.6 #{CREW_DEST_LIB_PREFIX}/libbz2.so"

    # Move manpages
    system "mkdir -p #{CREW_DEST_PREFIX}/share/man/"
    system "cp -a #{CREW_DEST_PREFIX}/man/* #{CREW_DEST_PREFIX}/share/man/"
    system "rm -rf #{CREW_DEST_PREFIX}/man"
  end

  def self.check
    system "make", "test"
  end
end
