require 'package'

class Libunistring < Package
  description 'A library that provides functions for manipulating Unicode strings and for manipulating C strings according to the Unicode standard.'
  homepage 'https://www.gnu.org/software/libunistring/'
  version '0.9.8'
  source_url 'https://ftp.gnu.org/gnu/libunistring/libunistring-0.9.8.tar.xz'
  source_sha256 '7b9338cf52706facb2e18587dceda2fbc4a2a3519efa1e15a3f2a68193942f80'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libunistring-0.9.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libunistring-0.9.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libunistring-0.9.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libunistring-0.9.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0f4015848022ac926964112d19a3a6dce33e61479756b3cadded402a5a5808cf',
     armv7l: '0f4015848022ac926964112d19a3a6dce33e61479756b3cadded402a5a5808cf',
       i686: '127f133faad0ea53013d80e26672db31ab40b4c7379d88f18d6adbf0f2d1ed12',
     x86_64: '4cd2d13d86fdf810fa468bb7b3b37a42e0f68fa658897897dc0b24c8e0e58da5',
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
