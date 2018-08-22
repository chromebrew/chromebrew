require 'package'

class Libexiv2 < Package
  description 'Exiv2 is a Cross-platform C++ library and a command line utility to manage image metadata.'
  homepage 'http://exiv2.org/'
  version '0.26'
  source_url 'http://www.exiv2.org/builds/exiv2-0.26-trunk.tar.gz'
  source_sha256 'c75e3c4a0811bf700d92c82319373b7a825a2331c12b8b37d41eb58e4f18eafb'

  depends_on 'zlibpkg'
  depends_on 'gettext'
  depends_on 'libiconv'
  depends_on 'expat'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.check
    system "make check"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
