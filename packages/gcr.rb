require 'package'

class Gcr < Package
  description 'GNOME crypto package'
  homepage 'https://www.gnome.org'
  version '3.36.0'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/gcr/3.36/gcr-3.36.0.tar.xz'
  source_sha256 'aaf9bed017a2263c6145c89a1a84178f9f40f238426463e4ae486694ef5f6601'

  depends_on 'pygtk'
  depends_on 'libgcrypt'
  depends_on 'libxslt'
  depends_on 'desktop_file_utilities'
  depends_on 'hicolor_icon_theme'
  depends_on 'gnupg'
  depends_on 'glib'
  depends_on 'gnupg'
  depends_on 'libxslt'

  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} _build -Dgtk_doc=false" # Due to issues with gtk_doc it has been disabled; I will revist this when gtk_doc is fixed
    system 'ninja -v -C _build'
  end
  
  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
  end
end
