require 'package'

class Libedit < Package
  description 'This is an autotool and libtoolized port of the NetBSD Editline library (libedit).'
  homepage 'http://thrysoee.dk/editline/'
  version '20191231-3.1-1'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://thrysoee.dk/editline/libedit-20191231-3.1.tar.gz'
  source_sha256 'dbb82cb7e116a5f8025d35ef5b4f7d4a3cdd0a3909a146a39112095a2d229071'

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto \"-I#{CREW_PREFIX}/include/ncurses\"' LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} \
      CPPFLAGS=\"-I#{CREW_PREFIX}/include/ncursesw\""
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
