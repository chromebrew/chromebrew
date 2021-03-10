require 'package'

class Geocode_glib < Package
  description 'Helper library for geocoding services'
  homepage 'https://gitlab.gnome.org/GNOME/geocode-glib'
  version '3.26.2'
  compatibility 'all'
  source_url 'https://github.com/GNOME/geocode-glib/archive/3.26.2.tar.gz'
  source_sha256 '589ed8cf890fb47619ad1062b7117d16104554078b837344496d603d0896ec20'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/geocode_glib-3.26.2-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/geocode_glib-3.26.2-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/geocode_glib-3.26.2-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/geocode_glib-3.26.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'f74ba83a0df6933228dd95b002338a8240fc2b214607aed1336ff39977ac1eb6',
      armv7l: 'f74ba83a0df6933228dd95b002338a8240fc2b214607aed1336ff39977ac1eb6',
        i686: '14df38272b852f20219f566d0e3af5d1d80f9f1764d2058810225c351f1372bb',
      x86_64: 'e09c747ba0471e2a50205b0d107832aa3f3828425e0ffaf0bb1b67568c3b369c',
  })

  depends_on 'json_glib'
  depends_on 'libsoup'
  depends_on 'gobject_introspection' => ':build'
  depends_on 'gtk_doc' => ':build'

  def self.patch
    system "sed -i 's/gnome/Adwaita/' icons/meson.build"
  end

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Dsystemd=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
