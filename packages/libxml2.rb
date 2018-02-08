require 'package'

class Libxml2 < Package
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version '2.9.7-1'
  source_url 'ftp://xmlsoft.org/libxml2/libxml2-2.9.7.tar.gz'
  source_sha256 'f63c5e7d30362ed28b38bfa1ac6313f9a80230720b7fb6c80575eeab3ff5900c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.7-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.7-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.7-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.7-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f85fc0891eacc8785930f689321b7771ece6679d520cc6ecc4cd2c9e15b5d8d7',
     armv7l: 'f85fc0891eacc8785930f689321b7771ece6679d520cc6ecc4cd2c9e15b5d8d7',
       i686: 'e26444996080e19026958bc6a434623f0a48a3116c34e32b5b730683d010a2e9',
     x86_64: 'e9b0b85c681e748b4532bd201503caaee5fcce8f73849d7199bf80634e9cbbba',
  })
 
  depends_on 'python27'
  depends_on 'zlibpkg'

  def self.build
    system "./configure",
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      "--enable-shared",
      "--disable-static",
      "--with-pic",
      "--with-python",
      "--without-lzma",
      "--with-zlib"
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
