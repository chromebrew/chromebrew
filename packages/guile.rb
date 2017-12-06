require 'package'

class Guile < Package
  description 'Guile is designed to help programmers create flexible applications that can be extended by users or other programmers with plug-ins, modules, or scripts.'
  homepage 'http://www.gnu.org/software/guile/'
  version '2.2.3-1'
  source_url 'https://ftp.gnu.org/gnu/guile/guile-2.2.3.tar.xz'
  source_sha256 '8353a8849cd7aa77be66af04bd6bf7a6207440d2f8722e46672232bb9f0a4086'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'diffutils' => :build
  depends_on 'libtool'
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
