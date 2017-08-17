require 'package'

class Ffcall < Package
  description 'Foreign function call is a collection of four libraries which can be used to build foreign function call interfaces in embedded interpreters.'
  homepage 'http://www.haible.de/bruno/packages-ffcall-README.html'
  version '1.10-1'
  source_url 'http://www.haible.de/bruno/gnu/ffcall-1.10.tar.gz'
  source_sha256 '6f1b5b8fc84b2c0051637fb1e4e4f8b975f5f98bff8fe053c1992347baa4983d'

  binary_url ({
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ffcall-1.10-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ffcall-1.10-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
       i686: '9d64fa08b420b2e0e04545d905fd3a06ee3c42c9fb6770d41f455395a4255344',
     x86_64: 'd7a2d2cb69fa4ce1a9e9da530a2fa3228b48a9d4c70195f73b96eea9237b543e',
  })

  def self.build
    system "./configure --prefix=/usr/local CFLAGS=\" -fPIC\""

    # force to compile in sequential since ffcall Makefile doesn't work in parallel
    system "make", "-j1"
  end

  def self.install
    system "make check"

    # ffcall's `make install` doesn't create intermediate directory, so prepare for it here.
    system "mkdir", "-p", "#{CREW_DEST_DIR}/usr/local"

    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
