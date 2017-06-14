require 'package'

class Libtool < Package
  description 'GNU libtool is a generic library support script. Libtool hides the complexity of using shared libraries behind a consistent, portable interface.'
  homepage 'https://www.gnu.org/software/libtool/'
  version '2.4.6'
  source_url 'https://ftp.gnu.org/gnu/libtool/libtool-2.4.6.tar.gz'
  source_sha1 '25b6931265230a06f0fc2146df64c04e5ae6ec33'

  depends_on 'buildessential'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
