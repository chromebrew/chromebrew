require 'package'

class Macchanger < Package
  description 'GNU MAC Changer is an utility that makes the maniputation of MAC addresses of network interfaces easier.'
  homepage 'http://www.gnu.org/software/macchanger/'
  version '1.7.0'
  compatibility 'all'
  source_url 'https://github.com/alobbs/macchanger/releases/download/1.7.0/macchanger-1.7.0.tar.gz'
  source_sha256 'dae2717c270fd5f62d790dbf80c19793c651b1b26b62c101b82d5fdf25a845bf'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
  def self.check
    system "make", "check"
  end
end
