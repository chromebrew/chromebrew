require 'package'

class Pkg_config < Package
  version '0.29.1'
  source_url 'https://pkg-config.freedesktop.org/releases/pkg-config-0.29.1.tar.gz' # software source tarball url
  source_sha1 '271ce928f6d673cc16cbced2bfd14a5f2e5d3d37'                     # source tarball sha1 sum


  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure","--prefix=/usr/local","--with-internal-glib","--disable-host-tool"
    system "make"                                                 # ordered chronologically
  end

  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end
end
