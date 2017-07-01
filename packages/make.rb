require 'package'

class Make < Package
  description 'GNU Make is a tool which controls the generation of executables and other non-source files of a program from the program\'s source files.'
  homepage 'https://www.gnu.org/software/make/'
  version '4.2'
  source_url 'ftp://ftp.gnu.org/gnu/make/make-4.2.tar.bz2'
  source_sha256 '4e5ce3b62fe5d75ff8db92b7f6df91e476d10c3aceebf1639796dc5bfece655f'

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
