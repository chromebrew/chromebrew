require 'package'

class Pcre < Package
  description 'The PCRE library is a set of functions that implement regular expression pattern matching using the same syntax and semantics as Perl 5.'
  homepage 'http://pcre.org/'
  version '8.44-1'
  compatibility 'all'
  source_url 'https://ftp.pcre.org/pub/pcre/pcre-8.44.tar.bz2'
  source_sha256 '19108658b23b3ec5058edc9f66ac545ea19f9537234be1ec62b714c84399366d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pcre-8.44-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pcre-8.44-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pcre-8.44-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pcre-8.44-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b6475dc3ff52f0c471d320a7c7d7a17ad015f2f08b46f4fc6805d80efb80ec10',
     armv7l: 'b6475dc3ff52f0c471d320a7c7d7a17ad015f2f08b46f4fc6805d80efb80ec10',
       i686: 'abb6faf10ed437b2fdef5bd6da661a2327d2ffa79dfbdf7f3bc12713da1370cf',
     x86_64: '4f2e3865d910f15b113c59cb69ce87dedbc236a8f655304ffb3fe8ceb89ab64a',
  })

  def self.build
    system "./configure #{CREW_OPTIONS} \
  --enable-shared \
  --disable-static \
  --with-pic \
  --enable-utf \
  --enable-pcre16 \
  --enable-pcre32 \
  --enable-jit \
  --enable-pcretest-libreadline"
    system 'make'
  end

  def self.check
#    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
