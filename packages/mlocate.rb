require 'package'

class Mlocate < Package
  version '0.26'
  source_url 'https://releases.pagure.org/mlocate/mlocate-0.26.tar.xz'           # software source tarball url
  source_sha1 'c6e6d81b25359c51c545f4b8ba0f3b469227fcbc'                         # source tarball sha1 sum
  
  def self.build                                                                 # self.build contains commands needed to build the software from source
    system "mkdir -p /usr/local/db/mlocate"                                      # create dbdir directory where mlocate.db will be generated
    system "sed -i 's,\$(localstatedir)/,/usr/local/db/,g' Makefile.*"           # change from /var (symlinked from /usr/local/var) to /usr/local/db
    system "sed -i \"s/groupname = mlocate/groupname = $(whoami)/g\" Makefile.*" # change groupname in all Makefiles to avoid permission issues
    system "./configure"
    system "make"                                                                # ordered chronologically
  end

  def self.install                                                               # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"                         # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end
end
