require 'package'

class Libxml2 < Package
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version '2.9.8-2'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.9.8/libxml2-v2.9.8.tar.bz2'
  source_sha256 '75f60530c4ff9717930ea28abcf3dfc4b213ac7617884f37637d069b01032b8a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.8-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.8-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.8-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.8-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '51646006a23ab2adcf59c464c0358b4cde2c78707d25fc736cfcabb16e37bb27',
     armv7l: '51646006a23ab2adcf59c464c0358b4cde2c78707d25fc736cfcabb16e37bb27',
       i686: '11b78a2921229406fcff2e8421df0a58d27ec97c7bfcc89f908583f46dafd71c',
     x86_64: '2b1ecd272734fd960d79d75187313e581911971466ad99f360e24a5fc0e19e6a',
  })
 
  depends_on 'libz'

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
