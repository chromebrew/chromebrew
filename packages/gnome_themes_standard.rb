require 'package'

class Gnome_themes_standard < Package
  description 'Standard Themes for GNOME Applications.'
  homepage 'https://git.gnome.org/browse/gnome-themes-standard/'
  version '3.27.92-0'
  source_url 'https://github.com/GNOME/gnome-themes-extra/archive/3.27.92.tar.gz'
  source_sha256 'c2c2b02e6826d51de4e6e53afffbdb0ec301ef776df91944574fdc42b558cecb'

  
  depends_on 'gtk3'
  depends_on 'gtk2'
  depends_on 'librsvg'
  depends_on 'gdk_pixbuf'
  depends_on 'gnome_common'

  def self.build
    system "sh autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
  
end
