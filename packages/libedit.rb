require 'package'

class Libedit < Package
  description 'This is an autotool and libtoolized port of the NetBSD Editline library (libedit).'
  homepage 'http://thrysoee.dk/editline/'
  version '3.1-0'
  source_url 'https://thrysoee.dk/editline/libedit-20170329-3.1.tar.gz'
  source_sha256 '91f2d90fbd2a048ff6dad7131d9a39e690fd8a8fd982a353f1333dd4017dd4be'


  def self.build
    system "./configure",
	   "--prefix=#{CREW_PREFIX}", 
	   "--libdir=#{CREW_LIB_PREFIX}",
           "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
