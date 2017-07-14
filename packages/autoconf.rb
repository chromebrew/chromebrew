require 'package'

class Autoconf < Package
  description 'Autoconf is an extensible package of M4 macros that produce shell scripts to automatically configure software source code packages.'
  homepage 'http://www.gnu.org/software/autoconf/'
  version '2.69'
  source_url 'ftp://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.xz'
  source_sha256 '64ebcec9f8ac5b2487125a86a7760d2591ac9e1d3dbd59489633f9de62a57684'

  depends_on 'perl'
  depends_on 'm4'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
