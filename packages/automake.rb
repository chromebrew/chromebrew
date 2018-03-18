require 'package'

class Automake < Package
  description 'Automake is a tool for automatically generating Makefile.in files compliant with the GNU Coding Standards.'
  homepage 'http://www.gnu.org/software/automake/'
  version '1.16'
  source_url 'https://ftpmirror.gnu.org/automake/automake-1.16.tar.xz'
  source_sha256 'f98f2d97b11851cbe7c2d4b4eaef498ae9d17a3c2ef1401609b7b4ca66655b8a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/automake-1.16-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/automake-1.16-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/automake-1.16-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/automake-1.16-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '089e81eadacd9f85839aa3d098e4234de2f8513a374c89a35ba29578145ee92f',
     armv7l: '089e81eadacd9f85839aa3d098e4234de2f8513a374c89a35ba29578145ee92f',
       i686: '9e8d8d0101feee02421bad6f0b2103132c7687787e83be9070ab488360c89134',
     x86_64: '95124590f1ab0c5b3de3084ecedf54b09d8dd3500e4c5041498032d8dd82c3a3',
  })

  depends_on 'autoconf'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
