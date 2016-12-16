require 'package'

class Moonbuggy < Package
  version '1.0.51'
  source_url 'http://m.seehuhn.de/programs/moon-buggy-1.0.51.tar.gz' # software source tarball url
  source_sha1 '7f1c5df99944acfe98eeb5f8d5ab6f28ef61ee7e'                  # source tarball sha1 sum

  depends_on 'ncurses'

  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure"
    system "make"                                                 # ordered chronologically
  end

  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end
end
