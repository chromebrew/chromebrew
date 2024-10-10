require 'buildsystems/meson'

class Localsearch < Meson
  description 'Collection of data extractors for Tracker/Nepomuk'
  homepage 'https://gitlab.gnome.org/GNOME/localsearch'
  version "3.7.3-#{CREW_ICU_VER}"
  license 'GPLv2+'
  compatibility 'x86_64 aarch64 armv7l'
  min_glibc '2.37'
  source_url 'https://gitlab.gnome.org/GNOME/localsearch.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ee07d7ac54e1e98360299f1deb15c754cc9bb826eae128e002e8f0fa4af730de',
     armv7l: 'ee07d7ac54e1e98360299f1deb15c754cc9bb826eae128e002e8f0fa4af730de',
     x86_64: 'ce85968eb93fe979aed0276475ed12ade0a0e1e99b182a32f01f6b644e9b25be'
  })

  depends_on 'asciidoc' => :build
  depends_on 'exempi' # R
  depends_on 'gcc_lib' => :build
  depends_on 'gexiv2' # R
  depends_on 'giflib' # R
  depends_on 'glibc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gstreamer' # R
  depends_on 'icu4c' # R
  depends_on 'libcue' # R
  depends_on 'libexif' # R
  depends_on 'libgrss' # R
  depends_on 'libgsf' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libpng' # R
  depends_on 'libseccomp' # R
  depends_on 'libtiff' # R
  depends_on 'libxml2' # R
  depends_on 'poppler' # R
  depends_on 'tinysparql' # R
  depends_on 'util_linux' # R
  depends_on 'vala' => :build

  gnome

  meson_options "-Dbattery_detection=none \
      -Ddbus_services_dir=#{CREW_PREFIX}/share/dbus-1/services/ \
      -Dlandlock=disabled \
      -Dman=false \
      -Dsystemd_user_services=false"
end
