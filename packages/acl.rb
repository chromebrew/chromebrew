require 'package'

class Acl < Package
  description 'Commands for Manipulating POSIX Access Control Lists.'
  homepage 'http://savannah.nongnu.org/projects/acl'
  version '2.2.52'
  source_url 'http://download.savannah.gnu.org/releases/acl/acl-2.2.52.src.tar.gz'
  source_sha256 '179074bb0580c06c4b4137be4c5a92a701583277967acdb5546043c7874e0d23'

  depends_on 'attr'

  def self.build
    system './configure --prefix=/usr/local --libexecdir=/usr/local/lib --disable-static'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-dev"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-lib"
  end
end
