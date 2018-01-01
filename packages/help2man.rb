require 'package'

class Help2man < Package
  description "help2man produces simple manual pages from the '--help' and '--version' output of other commands."
  homepage 'https://www.gnu.org/software/help2man/'
  version '1.47.5'
  source_url 'https://mirror.sergal.org/gnu/help2man/help2man-1.47.5.tar.xz'
  source_sha256 '7ca60b2519fdbe97f463fe2df66a6188d18b514bfd44127d985f0234ee2461b1'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
