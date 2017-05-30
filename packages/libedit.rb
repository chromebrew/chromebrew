require 'package'

class Libedit < Package
  description 'This is an autotool and libtoolized port of the NetBSD Editline library (libedit).'
  homepage 'http://thrysoee.dk/editline/'
  version '3.1'
  source_url 'http://thrysoee.dk/editline/libedit-20160903-3.1.tar.gz'
  source_sha1 '55e327ee4661b13d20ebb411d790f2bb258271cf'

  def self.build
    system './configure --prefix=/usr/local CPPFLAGS="-I/usr/local/include/ncurses"'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" 
  end
end
