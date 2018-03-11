require 'package'

class Gnome_themes_standard < Package
  description 'Standard Themes for GNOME Applications. https://git.gnome.org/browse/gnome-themes-standard/'
  homepage 'https://github.com/GNOME/gnome-themes-extra/releases'
  version '3.27.92'
  source_url 'https://github.com/GNOME/gnome-themes-extra/archive/3.27.92.tar.gz'
  source_sha256 'c2c2b02e6826d51de4e6e53afffbdb0ec301ef776df91944574fdc42b558cecb'

  binary_url ({
  })
  binary_sha256 ({
  })
  
  depends_on 'gtk3'
  depends_on 'gtk2'
  depends_on 'librsvg'
  depends_on 'gdk_pixbuf'

  def self.build
    system "sh autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
  
end
