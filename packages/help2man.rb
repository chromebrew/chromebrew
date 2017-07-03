require 'package'

class Help2man < Package
  description "help2man produces simple manual pages from the '--help' and '--version' output of other commands."
  homepage 'https://www.gnu.org/software/help2man/'
  version '1.47.4'
  source_url 'http://ftpmirror.gnu.org/help2man/help2man-1.47.4.tar.xz'
  source_sha256 'ac1a227a7a621f976489af804435ab1160c29fc4e45a8e34d3904d8915b71773'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
