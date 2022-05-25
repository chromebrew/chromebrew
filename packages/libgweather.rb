require 'package'

class Libgweather < Package
  description 'Location and timezone database and weather-lookup library'
  homepage 'https://wiki.gnome.org/Projects/LibGWeather'
  version '4.2.0'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libgweather/-/archive/4.2.0/libgweather-4.2.0.tar.bz2'
  source_sha256 '028cdca5005a17d88e78461e72c6b5c519e2df33f2e456075aeea9dc455aca20'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgweather/4.2.0_armv7l/libgweather-4.2.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgweather/4.2.0_armv7l/libgweather-4.2.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgweather/4.2.0_i686/libgweather-4.2.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgweather/4.2.0_x86_64/libgweather-4.2.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '40a0fe50c8ec6ac566a278531b27633a226d7aab695b91fb90b97a039775be47',
     armv7l: '40a0fe50c8ec6ac566a278531b27633a226d7aab695b91fb90b97a039775be47',
       i686: '86a11111e713a7e1ff3fe4c59edbc8ab0395d31864735fa9fc6a29282ec3dd3f',
     x86_64: '3977878b91e477fcb590870b8595daf53e6a032bcf8a793da5bf6d1285b3ffe7'
  })

  depends_on 'libsoup'
  depends_on 'gtk3'
  depends_on 'dconf'
  depends_on 'geocode_glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'glade' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'libsoup2' # R
  depends_on 'libxml2' # R
  depends_on 'py3_gi_docgen' => :buuld
  depends_on 'py3_smartypants' => :build
  depends_on 'json_glib' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dsoup2=true \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
