require 'package'

class Libxml2 < Package
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version '2.9.8-1'
  source_url 'ftp://xmlsoft.org/libxml2/libxml2-2.9.8.tar.gz'
  source_sha256 '0b74e51595654f958148759cfef0993114ddccccbb6f31aee018f3558e8e2732'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.8-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.8-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.8-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.8-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ab6dfc5969c4220c58ec1a24d989e761158de397897345047bbe2d69d875c365',
     armv7l: 'ab6dfc5969c4220c58ec1a24d989e761158de397897345047bbe2d69d875c365',
       i686: '0f0b0fc514b0002207de170e99fe085f994db4307130b77bb6d9fbced6e09cdd',
     x86_64: '061f528bece488ea9d4b8ad5b4f033dd4d005a76a58878f2ae3ae437fdda8fd4',
  })
 

  def self.build
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
