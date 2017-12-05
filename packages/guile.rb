require 'package'

class Guile < Package
  description 'Guile is designed to help programmers create flexible applications that can be extended by users or other programmers with plug-ins, modules, or scripts.'
  homepage 'http://www.gnu.org/software/guile/'
  version '2.2.3'
  source_url 'https://ftp.gnu.org/gnu/guile/guile-2.2.3.tar.xz'
  source_sha256 '8353a8849cd7aa77be66af04bd6bf7a6207440d2f8722e46672232bb9f0a4086'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/guile-2.2.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/guile-2.2.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/guile-2.2.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/guile-2.2.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f47253fa04e2f3ef1b5d5733947b743c504c8c03d7493a8c6e69d43bf9075c93',
     armv7l: 'f47253fa04e2f3ef1b5d5733947b743c504c8c03d7493a8c6e69d43bf9075c93',
       i686: 'c44a08a53d61e5a921fadc988a21e2e375712460e39032d113d7f00c392e4b11',
     x86_64: '9b1709543ef02a249cabb77190b165e55862a31568fbb8291564e0e98aa3e01a',
  })

  depends_on 'diffutils' => :build
  depends_on 'libtool' => :build
  depends_on 'bdwgc'
  depends_on 'libffi'
  depends_on 'libunistring'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-dependency-tracking'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "gzip -9 #{CREW_DEST_PREFIX}/share/man/man1/guile.1"
  end
end
