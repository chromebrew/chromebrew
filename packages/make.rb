require 'package'

class Make < Package
  description 'GNU Make is a tool which controls the generation of executables and other non-source files of a program from the program\'s source files.'
  homepage 'https://www.gnu.org/software/make/'
  version '4.2'
  source_url 'ftp://ftp.gnu.org/gnu/make/make-4.2.tar.bz2'
  source_sha1 'd78b84a219b4c16593544f541dff7eb765ce3d74'

  depends_on 'gcc' => :build
  depends_on 'linuxheaders' => :build

  def self.build
    system "./configure"
    system "./build.sh"
  end

  def self.install
    system "./make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"
  end

  def self.check
    # Give it several tries since output-sync fails rarely
    system "./make check || ./make check || ./make check"
  end
end
