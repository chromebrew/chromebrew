require 'package'

class Polari < Package
  description 'An IRC client from GNOME'
  homepage 'https://wiki.gnome.org/Apps/Polari/'
  version '3.38.0'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/polari/3.38/polari-3.38.0.tar.xz'
  source_sha256 '3af8a6d22e4fa7e121e29611edbe4c90c3266565f4c3a67332904c5c56b502d1'

  depends_on 'gtk3'
  depends_on 'libsecret'
  depends_on 'telepathy_glib'
  depends_on 'appstream_glib'
  depends_on 'telepathy_logger'
  depends_on 'gspell'
  depends_on 'gjs'
  depends_on 'desktop_file_utilities'
  depends_on 'sommelier'


  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
  
  def self.check
    system "ninja -C builddir test"
  end
end
