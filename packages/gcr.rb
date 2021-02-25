require 'package'

class Gcr < Package
  description 'GNOME crypto package'
  homepage 'https://www.gnome.org'
  version '3.38.1'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gcr/3.38/gcr-3.38.1.tar.xz'
  source_sha256 '17fcaf9c4a93a65fb1c72b82643bb102c13344084687d5886ea66313868d9ec9'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gcr-3.38.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gcr-3.38.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gcr-3.38.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gcr-3.38.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'a61f2009bc3bc00b18480b3f79954c4963bba4829f898e8247d1222322277fc5',
     armv7l: 'a61f2009bc3bc00b18480b3f79954c4963bba4829f898e8247d1222322277fc5',
       i686: '3790b41ac9f7e88192a1f59199d62c2d31d4f09edd60ce04f7d4f0a71750f1d4',
     x86_64: '9ed6176ff86030e47818c147ff2d54fa16aab1da29997caff364387b7858a7a5'
  })
  depends_on 'libgcrypt'
  depends_on 'libxslt'
  depends_on 'desktop_file_utilities'
  depends_on 'hicolor_icon_theme'
  depends_on 'gnupg'
  depends_on 'glib'
  depends_on 'gnupg'
  depends_on 'libxslt'
  depends_on 'vala' => :build
  depends_on 'gtk3'
  depends_on 'graphite'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Dgtk_doc=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
