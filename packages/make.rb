require 'package'

class Make < Package
  version '4.2'
  source_url 'ftp://ftp.gnu.org/gnu/make/make-4.2.tar.bz2'
  source_sha1 'd78b84a219b4c16593544f541dff7eb765ce3d74'

  depends_on 'linuxheaders'

  def self.build
    system "./configure"
    system "./build.sh"
  end

  def self.install
    system "./make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"
  end

  def self.check
    # Give it several tries since output-sync fails rarely
    system "./make check || ./make check || ./make check"
  end
end
