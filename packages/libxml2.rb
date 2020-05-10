require 'package'

class Libxml2 < Package
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version '2.9.9'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.9.9/libxml2-v2.9.9.tar.bz2'
  source_sha256 'd598e907b5f3efa992b65094f7113d9d8cc87238f32e4e1ddf8beff01b60a653'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8f7a474b5d0f8f800faa8e585662561dc4a0db3a494b2a949e96e63becf84262',
     armv7l: '8f7a474b5d0f8f800faa8e585662561dc4a0db3a494b2a949e96e63becf84262',
       i686: 'b248be959d940cb499e4692973865770a74fe1e10dfd7706cca36cc3ef3a0067',
     x86_64: 'd2a31a3c95de67b23488340deea7025cdf953700e141a629de11711d17d3794a',
  })
 
  depends_on 'zlibpkg'

  def self.build
    system './autogen.sh'
    system "./configure",
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      "--enable-shared",
      "--disable-static",
      "--with-pic",
      "--without-python",   # libxml2-python built in another package (libxml2_python)
      "--without-lzma",
      "--with-zlib",
      "--with-icu",
      "--with-threads",
      "--with-history"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    # Remove EBCDIC test since it fails.
    # Check https://mail.gnome.org/archives/xml/2010-April/msg00010.html for details.
    system "rm", "test/ebcdic_566012.xml"

    system "make", "check"
  end
end
