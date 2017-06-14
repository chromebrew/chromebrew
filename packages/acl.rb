require 'package'

class Acl < Package
  description 'Commands for Manipulating POSIX Access Control Lists.'
  homepage 'http://savannah.nongnu.org/projects/acl'
  version '2.2.52'
  source_url 'http://download.savannah.gnu.org/releases/acl/acl-2.2.52.src.tar.gz'
  source_sha1 '537dddc0ee7b6aa67960a3de2d36f1e2ff2059d9'

  depends_on "attr"

  def self.build
    system "./configure --prefix=/usr/local --libexecdir=/usr/local/lib --disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-dev"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-lib"
  end
end
