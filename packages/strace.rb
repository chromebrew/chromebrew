require 'package'

class Strace < Package
  description 'strace is a diagnostic, debugging and instructional userspace utility for Linux.'
  homepage 'https://strace.io/'
  version '5.2-1'
  compatibility 'all'
  source_url 'https://strace.io/files/5.2/strace-5.2.tar.xz'
  source_sha256 'd513bc085609a9afd64faf2ce71deb95b96faf46cd7bc86048bc655e4e4c24d2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/strace-5.2-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/strace-5.2-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/strace-5.2-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/strace-5.2-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2affe33b6758ed49fc50d140e7673f44e33fc72410597eb851fef5e9699a1afc',
     armv7l: '2affe33b6758ed49fc50d140e7673f44e33fc72410597eb851fef5e9699a1afc',
       i686: '233884ae2118bd1558f85a0bef68260bdc981075d7e5861233004c920438f3c4',
     x86_64: 'e5e6704b6749417a141f0c925294e53c1f0ff6119cfcd703cd156e0109ad5981',
  })

  depends_on 'elfutils' # Needed for stack trace support

  def self.patch
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' strace-graph"
  end

  def self.build
    system './configure',
           '--with-libdw',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
