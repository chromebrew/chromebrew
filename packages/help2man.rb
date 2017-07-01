require 'package'

class Help2man < Package
  description "help2man produces simple manual pages from the '--help' and '--version' output of other commands."
  homepage 'https://www.gnu.org/software/help2man/'
  version '1.47.4'
  source_url 'http://gnu.mirror.globo.tech/help2man/help2man-1.47.4.tar.xz'
  source_sha256 'd4ecf697d13f14dd1a78c5995f06459bff706fd1ce593d1c02d81667c0207753'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
