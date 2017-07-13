require 'package'

class Libedit < Package
  description 'This is an autotool and libtoolized port of the NetBSD Editline library (libedit).'
  homepage 'http://thrysoee.dk/editline/'
  version '3.1'
  source_url 'http://thrysoee.dk/editline/libedit-20160903-3.1.tar.gz'
  source_sha256 '0ccbd2e7d46097f136fcb1aaa0d5bc24e23bb73f57d25bee5a852a683eaa7567'

  def self.build
    system './configure --prefix=/usr/local CPPFLAGS="-I/usr/local/include/ncurses"'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
