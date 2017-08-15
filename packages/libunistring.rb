require 'package'

class Libunistring < Package
  description 'A library that provides functions for manipulating Unicode strings and for manipulating C strings according to the Unicode standard.'
  homepage 'https://www.gnu.org/software/libunistring/'
  version '0.9.7-1'
  source_url 'http://ftp.gnu.org/gnu/libunistring/libunistring-0.9.7.tar.xz'
  source_sha256 '2e3764512aaf2ce598af5a38818c0ea23dedf1ff5460070d1b6cee5c3336e797'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libunistring-0.9.7-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libunistring-0.9.7-1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/libunistring-0.9.7-1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/libunistring-0.9.7-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b60d772a35c8de2066092dbc1fab4fc85b89a90f2629b0f1048662f49d437a21',
     armv7l: 'b60d772a35c8de2066092dbc1fab4fc85b89a90f2629b0f1048662f49d437a21',
       i686: '6da6bd489e9e9dc6b18f3b3be5b29898495b159a65ec0190541d189e6cac06c3',
     x86_64: '23b75c157f57f9dfbdc3cdfee48d1e1f612c674867679061b2c15b418bac6f82',
  })

  depends_on 'glibc'

  def self.build
    system "./configure", "--disable-static", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
