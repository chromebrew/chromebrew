require 'package'

class Gtk_theme_config < Package
  description 'Configure GTK theme colors. https://github.com/satya164/gtk-theme-config'
  homepage 'https://github.com/satya164/gtk-theme-config/releases'
  version '1.0'
  source_url 'https://github.com/satya164/gtk-theme-config/archive/v1.0.tar.gz'
  source_sha256 '174aac3ea43966168d120dbd9e0f23d7900d095ee1b0cf32472d59b0fdea8448'

  depends_on 'glib'
  depends_on 'gtk3'
  depends_on 'atk'
  depends_on 'pango'
  depends_on 'cairo'
  depends_on 'gobject_introspection'
  depends_on 'libx11'
  depends_on 'gdk_pixbuf'
  
  def self.build
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
  
end
