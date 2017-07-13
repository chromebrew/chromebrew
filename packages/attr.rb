require 'package'

class Attr < Package
  description 'Commands for Manipulating Filesystem Extended Attributes.'
  homepage 'http://savannah.nongnu.org/projects/attr'
  version '2.4.47'
  source_url 'http://download.savannah.gnu.org/releases/attr/attr-2.4.47.src.tar.gz'
  source_sha256 '25772f653ac5b2e3ceeb89df50e4688891e21f723c460636548971652af0a859'

  depends_on 'gettext'

  def self.build
    system "./configure --prefix=/usr/local --disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-dev"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-lib"
  end
end
