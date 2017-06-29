require 'package'

class Coreutils < Package
  description 'The GNU Core Utilities are the basic file, shell and text manipulation utilities of the GNU operating system.'
  homepage 'http://www.gnu.org/software/coreutils/coreutils.html'
  version '8.27'
  source_url 'http://ftp.gnu.org/gnu/coreutils/coreutils-8.27.tar.xz'
  source_sha256 '8891d349ee87b9ff7870f52b6d9312a9db672d2439d289bc57084771ca21656b'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
