require 'package'

class Libffi < Package
  description 'The libffi library provides a portable, high level programming interface to various calling conventions.'
  homepage 'https://sourceware.org/libffi/'
  version '3.3'
  compatibility 'all'
  source_url 'https://sourceware.org/pub/libffi/libffi-3.3.tar.gz'
  source_sha256 '72fba7922703ddfa7a028d513ac15a85c8d54c8d67f55fa5a4802885dc652056'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libffi-3.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libffi-3.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libffi-3.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libffi-3.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '22a2ec5efcbcf5b587f34f35489ee0976f5a1ed256f47a4ac87a240f804c0d02',
     armv7l: '22a2ec5efcbcf5b587f34f35489ee0976f5a1ed256f47a4ac87a240f804c0d02',
       i686: '8041e3401d2b9721a2dd87d31aff2b1b5380f7946c092d9a3c18f573ca6422f8',
     x86_64: 'aecc094eb0e5b961106ee3d4086f120a30555cb82b3b8263107d9cab4e6c278f',
  })

  def self.build
    system "./configure #{CREW_OPTIONS} --enable-shared --disable-static --with-pic --disable-debug --disable-dependency-tracking"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    # system "make check"         # DejaGNU required
  end
end
