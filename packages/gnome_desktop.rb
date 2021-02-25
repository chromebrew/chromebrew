require 'package'

class Gnome_desktop < Package
  description 'Library with common API for various GNOME modules'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-desktop'
  version '40.beta'
  compatibility 'all'
  source_url 'https://github.com/GNOME/gnome-desktop/archive/40.beta.tar.gz'
  source_sha256 'a982cbaa68aabfcaef0d6db69c936ee45d8f23475a4dd2bad60a49f0bb920451'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_desktop-40.beta-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_desktop-40.beta-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_desktop-40.beta-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_desktop-40.beta-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'd93d85cfdd762b023f8815be575e84707564aa7c279b92e4d1812253db13b964',
     armv7l: 'd93d85cfdd762b023f8815be575e84707564aa7c279b92e4d1812253db13b964',
       i686: '7f810e184dc981a419942ba4fe18070fb4b51be23044f9632da9b3fee66224c8',
     x86_64: '60d206c6594c4da2c9081784d7d4fec46553aa8f92ce228187de72dfec1e40fe'
  })

  depends_on 'gsettings_desktop_schemas'
  depends_on 'gtk3'
  depends_on 'libxkbfile'
  depends_on 'xkeyboard_config'
  depends_on 'iso_codes'
  depends_on 'gobject_introspection' => ':build'
  depends_on 'gtk_doc' => ':build'
  depends_on 'yelp_tools' => ':build'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Dsystemd=disabled \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
