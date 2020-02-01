require 'package'

class Hunspell_base < Package
  description 'Hunspell is a spell checker and morphological analyzer library'
  homepage 'http://hunspell.github.io/'
  version '1.7.0-1'
  source_url 'https://github.com/hunspell/hunspell/archive/v1.7.0.tar.gz'
  source_sha256 'bb27b86eb910a8285407cf3ca33b62643a02798cf2eef468c0a74f6c3ee6bc8a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/hunspell_base-1.7.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/hunspell_base-1.7.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/hunspell_base-1.7.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/hunspell_base-1.7.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e3e77aa133961b491fee9c7b139d3ae40f04a407faff775cf76a204a947a7b62',
     armv7l: 'e3e77aa133961b491fee9c7b139d3ae40f04a407faff775cf76a204a947a7b62',
       i686: 'd4cdc61aac3ab02d3234146364cb1c747e0c070a219197f6990f1d61877b3b13',
     x86_64: '9f7a88d1e448094147b004a80b62ec5e9cf25b5e93ccbb363a2dddb3461ed8a2',
  })

  depends_on 'readline'
  
  def self.build
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
