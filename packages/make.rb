require 'package'

class Make < Package
  description 'GNU Make is a tool which controls the generation of executables and other non-source files of a program from the program\'s source files.'
  homepage 'https://www.gnu.org/software/make/'
  version '4.2.1'
  source_url 'https://ftp.gnu.org/gnu/make/make-4.2.1.tar.bz2'
  source_sha256 'd6e262bf3601b42d2b1e4ef8310029e1dcf20083c5446b4b7aa67081fdffc589'

  depends_on 'gcc' => :build
  depends_on 'linuxheaders' => :build

  def self.build
    system "./configure"
    system "./build.sh"
  end

  def self.install
    system "./make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    # Give it several tries since output-sync fails rarely
    system "./make check || ./make check || ./make check"
  end
end
