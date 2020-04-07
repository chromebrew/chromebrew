require 'package'

class Gmp < Package
  description 'GMP is a free library for arbitrary precision arithmetic, operating on signed integers, rational numbers, and floating-point numbers.'
  homepage 'https://gmplib.org/'
  version '6.2.0'
  source_url 'https://gmplib.org/download/gmp/gmp-6.2.0.tar.lz'
  source_sha256 '3f33f127bcb6b2c3601676cd3281df45824b148cbf688b73c0fc8248793667d9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gmp-6.2.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gmp-6.2.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gmp-6.2.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gmp-6.2.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2808a85d261fb740f5278be8ea25aca44de63e7512fbbf5a19bf133db5b5c152',
     armv7l: '2808a85d261fb740f5278be8ea25aca44de63e7512fbbf5a19bf133db5b5c152',
       i686: '0bc6669b80774effaaad213e4b13c624fc879f62804672beea1244634c02c1c2',
     x86_64: '13f50bef5b6d30967fcd227dc750d972d5d2c1f471548c23dce5113dc952eeff',
  })

  def self.build
    system "sed -i 's,/usr/bin/file,#{CREW_PREFIX}/bin/file,g' configure"
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode',
           '--enable-cxx'
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
