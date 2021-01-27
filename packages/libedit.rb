require 'package'

class Libedit < Package
  description 'This is an autotool and libtoolized port of the NetBSD Editline library (libedit).'
  homepage 'http://thrysoee.dk/editline/'
  version '20191231-3.1'
  compatibility 'all'
  source_url 'https://thrysoee.dk/editline/libedit-20191231-3.1.tar.gz'
  source_sha256 'dbb82cb7e116a5f8025d35ef5b4f7d4a3cdd0a3909a146a39112095a2d229071'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libedit-20191231-3.1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libedit-20191231-3.1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/libedit-20191231-3.1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libedit-20191231-3.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '610986dcb014c2079b2b355628ee6f7b867076974cf751b891a926f0a0d9d5b8',
      armv7l: '610986dcb014c2079b2b355628ee6f7b867076974cf751b891a926f0a0d9d5b8',
        i686: 'dc3d211fd649803d0dd89c3f82163a8bf67eeebaea9629b14bd9e570ba545933',
      x86_64: '834915020f3fd98b0e3ca8609ae0b915b47ca77ea5877fa7b758a85571401e8e',
  })

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto \"-I#{CREW_PREFIX}/include/ncurses\"' LDFLAGS='-flto=auto' \
      ./configure \
      #{CREW_OPTIONS} \
      CPPFLAGS=\"-I#{CREW_PREFIX}/include/ncurses\""
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
