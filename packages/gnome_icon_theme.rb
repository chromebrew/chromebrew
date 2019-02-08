require 'package'

class Gnome_icon_theme < Package
  description 'GNOME Icon Theme'
  homepage 'https://ftp.gnome.org/pub/GNOME/sources/gnome-icon-theme/'
  version '3.12.0-1'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/gnome-icon-theme/3.12/gnome-icon-theme-3.12.0.tar.xz'
  source_sha256 '359e720b9202d3aba8d477752c4cd11eced368182281d51ffd64c8572b4e503a'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'icon_naming_utils'

  def self.build
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--enable-icon-mapping"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
