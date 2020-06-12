require 'package'

class Guile < Package
  description 'Guile is designed to help programmers create flexible applications that can be extended by users or other programmers with plug-ins, modules, or scripts.'
  homepage 'http://www.gnu.org/software/guile/'
  version '2.2.3-1'
  compatibility 'all'
  source_url 'https://ftp.gnu.org/gnu/guile/guile-2.2.3.tar.xz'
  source_sha256 '8353a8849cd7aa77be66af04bd6bf7a6207440d2f8722e46672232bb9f0a4086'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/guile-2.2.3-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/guile-2.2.3-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/guile-2.2.3-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/guile-2.2.3-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '418eb676b562f77b80e3dae974f35159c0f844284c8e98f02d6763ff08924d4e',
     armv7l: '418eb676b562f77b80e3dae974f35159c0f844284c8e98f02d6763ff08924d4e',
       i686: '18c2f42f3c60a6474854b89065c7d2de518693a1727a5dfd793fd76313a78ece',
     x86_64: '11a28901148adef29d90c96b6b28e2ff0caee7479588683cf3a919b9cea825e9',
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
