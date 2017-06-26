require 'package'

class Coreutils < Package
  description 'The GNU Core Utilities are the basic file, shell and text manipulation utilities of the GNU operating system.'
  homepage 'http://www.gnu.org/software/coreutils/coreutils.html'
  version '8.27'
  source_url 'http://ftp.gnu.org/gnu/coreutils/coreutils-8.27.tar.xz'
  source_sha1 'ee054c8a4c0c924de49e4f03266733f27f986fbb'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
