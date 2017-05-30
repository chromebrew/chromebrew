require 'package'

class Texinfo < Package
  description 'Texinfo is the official documentation format of the GNU project.'
  homepage 'https://www.gnu.org/software/texinfo/'
  version '6.3'
  source_url 'http://ftp.gnu.org/gnu/texinfo/texinfo-6.3.tar.gz' # software source tarball url
  source_sha1 '29b16c646c7bc9cd351b2f1d8dafdce70e5377f6'                  # source tarball sha1 sum

  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure"
    system "make"                                                 # ordered chronologically
  end

  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end
end
