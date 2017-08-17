require 'package'

class Cpio < Package
  description 'GNU cpio copies files into or out of a cpio or tar archive. The archive can be another file on the disk, a magnetic tape, or a pipe.'
  homepage 'https://www.gnu.org/software/cpio/'
  version '2.12'
  source_url 'http://ftp.gnu.org/gnu/cpio/cpio-2.12.tar.gz'
  source_sha256 '08a35e92deb3c85d269a0059a27d4140a9667a6369459299d08c17f713a92e73'

  depends_on 'binutils'
  depends_on 'gawk'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
