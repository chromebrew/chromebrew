require 'package'

class Libnotify < Package
  description 'A library for sending desktop notifications.'
  homepage 'https://git.gnome.org/browse/libnotify'
  version '0.7.7'
  source_url 'https://github.com/GNOME/libnotify/archive/0.7.7.tar.gz'
  source_sha256 '8ff216938a47df591b454ad062465f6d91d7a83496a1ba8eb755df8952cf48f2'

  binary_url ({
  })
  binary_sha256 ({
  })
  
  depends_on 'gdk_pixbuf'
  depends_on 'gobject_introspection'
  depends_on 'gtk_doc'
  depends_on 'gtk3'

  def self.build
    system "sh autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
  
end
