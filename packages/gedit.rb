require 'package'
  
class Gedit < Package
  description 'GNOME Text Editor'
  version '3.38.1'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gedit/3.38/gedit-3.38.1.tar.xz'
  source_sha256 '0053853d2cd59cad8a1662f5b4fdcfab47b4c0940063bacd6790a9948642844d'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gedit-3.38.1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gedit-3.38.1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/gedit-3.38.1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gedit-3.38.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '40be6aa1cbff4088e753298fc3f01194188347b942dd63ad16ad7450b158faa2',
      armv7l: '40be6aa1cbff4088e753298fc3f01194188347b942dd63ad16ad7450b158faa2',
        i686: 'a8f348c2e9b7fe96ec04d731d45b5af084b0545b6992a01dc44d6c468c8b20bb',
      x86_64: 'bab2efd640855fdf964b706615b6b874d5bb144a4a509a47edc7e85088d0b8a6',
  })

  depends_on 'gtksourceview'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'libpeas'
  depends_on 'gspell'
  depends_on 'pygobject'
  depends_on 'yelp_tools' => ':build'
  depends_on 'vala' => ':build'
  depends_on 'gobject_introspection' => ':build'
  depends_on 'gtk_doc' => ':build'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Drequire_all_tests=false \
    -Duser_documentation=false \
    builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
