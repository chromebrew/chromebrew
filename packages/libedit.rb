require 'package'

class Libedit < Package
  description 'This is an autotool and libtoolized port of the NetBSD Editline library (libedit).'
  homepage 'http://thrysoee.dk/editline/'
  version '3.1'
  source_url 'http://thrysoee.dk/editline/libedit-20160903-3.1.tar.gz'
  source_sha256 '0ccbd2e7d46097f136fcb1aaa0d5bc24e23bb73f57d25bee5a852a683eaa7567'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libedit-3.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libedit-3.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libedit-3.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libedit-3.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c16ef3b783845045e9026350145fca0945174c32b48fafc9d59d26c7337c7803',
     armv7l: 'c16ef3b783845045e9026350145fca0945174c32b48fafc9d59d26c7337c7803',
       i686: '1ae2463e6d6438b10d5d3281d37129a4a99af9a6fab6ba9e36d6e90a0a741486',
     x86_64: '68a48901fe14c09f776c64241114f24de461d3eda6fdd38833e7b6e00ebe344e',
  })

  def self.build
    system './configure --prefix=/usr/local CPPFLAGS="-I/usr/local/include/ncurses"'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
