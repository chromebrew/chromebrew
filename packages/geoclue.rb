require 'package'

class Geoclue < Package
  description 'Modular geoinformation service built on the D-Bus messaging system'
  homepage 'https://www.freedesktop.org/wiki/Software/GeoClue/'
  version '2.5.7'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/geoclue/geoclue/-/archive/2.5.7/geoclue-2.5.7.tar.bz2'
  source_sha256 '6cc7dbe4177b4e7f3532f7fe42262049789a3cd6c55afe60a3564d7394119c27'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/geoclue-2.5.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/geoclue-2.5.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/geoclue-2.5.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/geoclue-2.5.7-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'ca4c050657f094f10ccf46f4cba13d309d0757830c4be084e8190d72e3ca8949',
     armv7l: 'ca4c050657f094f10ccf46f4cba13d309d0757830c4be084e8190d72e3ca8949',
       i686: 'cb9adf521670add9b3d4d0e4491daa10965ab2638f0b5da89ea81a8df0870688',
     x86_64: '85a1879573e68dea80192fade6cdd52934ea0b2c02c22e959ec3a88b029f144b'
  })

  depends_on 'libsoup'
  depends_on 'json_glib'
  depends_on 'avahi'
  depends_on 'geocode_glib'
  depends_on 'gobject_introspection' => ':build'
  depends_on 'gtk_doc' => ':build'
  depends_on 'libnotify' => ':build'
  depends_on 'modemmanager'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
      -Dsystemd=disabled \
      -D3g-source=false \
      -Dcdma-source=false \
      -Dmodem-gps-source=false \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
