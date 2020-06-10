require 'package'

class Mpfr < Package
  description 'The MPFR library is a C library for multiple-precision floating-point computations with correct rounding.'
  homepage 'http://www.mpfr.org/'
  version '4.0.1'
  compatibility 'all'
  source_url 'http://www.mpfr.org/mpfr-current/mpfr-4.0.1.tar.xz'
  source_sha256 '67874a60826303ee2fb6affc6dc0ddd3e749e9bfcb4c8655e3953d0458a6e16e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mpfr-4.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mpfr-4.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mpfr-4.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mpfr-4.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '95fb95f4a32a0c91e48c3dee207710614eb44d1e98f3e43d7d439c5be7c1e5eb',
     armv7l: '95fb95f4a32a0c91e48c3dee207710614eb44d1e98f3e43d7d439c5be7c1e5eb',
       i686: '1f2598510252794e1eb9c98a132ddc7ad394c2c369cdfa4a690f50a2c981026f',
     x86_64: 'e5d43065f3f87eabf33debd0c9789988f980d68a0f1a91d6782b3f97916c0680',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-static',
           '--enable-shared'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "mkdir -p #{CREW_DEST_LIB_PREFIX}"
    system "ln -s #{CREW_LIB_PREFIX}/libmpfr.so.6 #{CREW_DEST_LIB_PREFIX}/libmpfr.so.4"
  end

  def self.check
    system "make", "check"
  end
end
