require 'package'

class Gawk < Package
  version '4.1.4'
  source_url 'http://ftp.gnu.org/gnu/gawk/gawk-4.1.4.tar.xz'
  source_sha1 'd67e00e2f6178e9cbd2c0ba923ae157bc0b3b570'

  def self.build
    system './configure --prefix=/usr/local'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
