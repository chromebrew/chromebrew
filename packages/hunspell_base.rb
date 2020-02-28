require 'package'

class Hunspell_base < Package
  description 'Hunspell is a spell checker and morphological analyzer library'
  homepage 'http://hunspell.github.io/'
  version '1.7.0-1'
  source_url 'https://github.com/hunspell/hunspell/archive/v1.7.0.tar.gz'
  source_sha256 'bb27b86eb910a8285407cf3ca33b62643a02798cf2eef468c0a74f6c3ee6bc8a'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'readline'
  depends_on 'ncurses'
  
  def self.build
    system 'cp /home/chronos/user/Downloads/configure.ac .'
    system 'autoreconf -vfi'
    system "./configure",
           "CPPFLAGS=-I#{CREW_PREFIX}/include -I#{CREW_PREFIX}/include/ncursesw -I#{CREW_PREFIX}/include/ncurses",
           "--prefix=#{CREW_PREFIX}",
           "--include=#{CREW_PREFIX}/include",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--with-ui',
           '--with-readline'
    system "sed -i 's,/usr/share,#{CREW_PREFIX}/share,g' man/hunspell.1"
    system "sed -i 's,/usr/share,#{CREW_PREFIX}/share,g' src/tools/hunspell.cxx"
    system "sed -i 's,ncurses.h,#{CREW_PREFIX}/include/ncursesw/ncurses.h,' src/tools/hunspell.cxx"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
