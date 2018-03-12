require 'package'

class Xfce4_dev_tools < Package
  description 'A set of scripts and m4/autoconf macros that ease build system maintenance. https://www.xfce.org/'
  homepage 'https://sourceforge.net/projects/gentoo/files/gentoo/'
  version '4.12.0'
  source_url 'https://github.com/xfce-mirror/xfce4-dev-tools/archive/xfce4-dev-tools-4.12.0.tar.gz'
  source_sha256 '50eee04bc13fedfa8f4aa4e6e329285569d3fe8b27cf1584f431ce279b59ba0b'

  depends_on 'glib'
  depends_on 'gtk_doc'

  def self.build
    system "sh autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
  
end
