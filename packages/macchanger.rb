require 'package'

class Macchanger < Package
  description 'GNU MAC Changer is an utility that makes the maniputation of MAC addresses of network interfaces easier.'
  homepage 'http://www.gnu.org/software/macchanger/'
  version '1.7.0'
  compatibility 'all'
  source_url 'https://ftp.gnu.org/gnu/macchanger/macchanger-1.6.0.tar.gz'
  source_sha256 '31534f138f1d21fa247be74ba6bef3fbfa47bbcd5033e99bd10c432fe58e51f7'

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
  def self.check
    system "make", "check"
  end
end
