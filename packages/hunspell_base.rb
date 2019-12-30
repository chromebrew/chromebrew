require 'package'

class Hunspell_base < Package
  description 'Hunspell is a spell checker and morphological analyzer library'
  homepage 'http://hunspell.github.io/'
  version '1.7.0'
  source_url 'https://github.com/hunspell/hunspell/archive/v1.7.0.tar.gz'
  source_sha256 'bb27b86eb910a8285407cf3ca33b62643a02798cf2eef468c0a74f6c3ee6bc8a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/hunspell_base-1.7.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/hunspell_base-1.7.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/hunspell_base-1.7.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/hunspell_base-1.7.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1827aa434bd7848d03d07ddc2b76c14c052aba16643acd33f494e6d4c3d78016',
     armv7l: '1827aa434bd7848d03d07ddc2b76c14c052aba16643acd33f494e6d4c3d78016',
       i686: '5348ba92a0e4b784aaad1875ffdb7a824b60d975bd721f8b86994693697a0840',
     x86_64: '83443d8cd8e21f25f346dcd6c7ada5a8a5ef0f01a1045addb43d263ab73d9136',
  })

  depends_on 'readline'
  
  def self.build
    system 'autoreconf -vfi'
    system './configure',
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
